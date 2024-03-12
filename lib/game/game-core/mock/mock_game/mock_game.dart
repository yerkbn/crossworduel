import 'dart:async';
import 'dart:math';

import 'package:crossworduel/game/domain/entities/player_entity.dart';
import 'package:crossworduel/game/game-core/crossword/crossoword_picker_manager.dart';
import 'package:crossworduel/game/game-core/mock/mock.dart';
import 'package:crossworduel/game/game-core/mock/mock_game/mock_instruction.dart';

class MockGame extends MockParent {
  static const int GAME_TIME = 100;
  static const int MAX_POINT = 50;
  late Timer _timer;
  int _start = GAME_TIME;
  final MockCore core;
  final MockInstructionMapper _instrtructionMapper = MockInstructionMapper();
  // local state
  late CrosswordPickerManager _picker;
  late List<Map<String, dynamic>> _currentCrossword;

  late PlayerEntity me = PlayerEntity.fromMe(config.me);

  late PlayerEntity opponent = PlayerEntity.random(config.me);

  int meCorrectCnt = 0;
  int opponentCorrectCnt = 0;

  MockGame(super.config) : core = MockCore(config);

  void close() {
    _timer.cancel();
  }

  void opponentMove({required bool isMust}) {
    Random rd = Random();
    if (_start > 20 && meCorrectCnt < 5 && (isMust || rd.nextBool())) {
      Future.delayed(Duration(seconds: rd.nextInt(10)), () {
        opponent = opponent.copyWith(
            progressPoint: opponent.progressPoint + getPointForCorrect());
        moveIns(duration: 0, player: opponent.toJson());
      });
    }
  }

  void _startTimer() {
    const sec = Duration(seconds: 1);
    _timer = Timer.periodic(
      sec,
      (Timer timer) {
        if (_start == 0) {
          finalIns(duration: 0, meDelta: getMeDelta());
          timer.cancel();
        } else {
          _start--;
        }
      },
    );
  }

  int getDeltaMagnitude(delta) {
    if (delta != 0) {
      /// delta will be in range 0 - 300;
      /// magnitude will be in range 0 - 5
      if (delta < 50) return 1;
      if (delta < 100) return 2;
      if (delta < 150) return 3;
      if (delta < 200) return 4;
      return 5;
    }
    return 0;
  }

  int getMeDelta() {
    int progressDelta = me.progressPoint - opponent.progressPoint;
    int deltaMagnitude = getDeltaMagnitude(progressDelta.abs());
    return (progressDelta > 0) ? deltaMagnitude : deltaMagnitude * -1;
  }

  int getPointForCorrect() {
    return (MAX_POINT * (_start / GAME_TIME)).round() + 1;
  }

  @override
  void runTest() {
    super.runTest();
    opponentMove(isMust: false);
    _init();
  }

  Future<void> _init() async {
    roomCreated(duration: 0, me: me.toJson());
    _picker = await CrosswordPickerManager.create();
    await Future.delayed(const Duration(milliseconds: 100));
    playerFound(duration: 0, opponent: opponent.toJson(), me: me.toJson());
    await Future.delayed(const Duration(milliseconds: 200));
    _currentCrossword = _picker.pick();
    _startTimer();
    running(duration: 0, result: _currentCrossword);
  }

  @override
  void add(String message) {
    final MockInstructionData instruction = _instrtructionMapper.parse(message);
    if (instruction is MoveMockInsD) {
      if (_currentCrossword.length == instruction.correctCnt) {
        me =
            me.copyWith(progressPoint: me.progressPoint + getPointForCorrect());
        moveIns(duration: 0, player: me.toJson());

        /// wait some time

        meCorrectCnt = instruction.correctCnt;
        finalIns(duration: 1000, meDelta: getMeDelta());
      } else if (instruction.correctCnt > meCorrectCnt) {
        opponentMove(isMust: false);
        meCorrectCnt = instruction.correctCnt;
        me =
            me.copyWith(progressPoint: me.progressPoint + getPointForCorrect());
        moveIns(duration: 0, player: me.toJson());
      }
    }
  }

  /// --- instructions ---
  void roomCreated({required int duration, required Map<String, dynamic> me}) =>
      execute(duration: duration, input: {
        "status": "ROOM_CREATED",
        "data": {"me": me, "roomId": "0"}
      });

  void playerFound(
          {required int duration,
          required Map<String, dynamic> opponent,
          required Map<String, dynamic> me}) =>
      execute(duration: duration, input: {
        "status": "PLAYER_FOUND",
        "data": {
          "players": [me, opponent]
        }
      });

  Future<void> running(
      {required int duration,
      required List<Map<String, dynamic>> result}) async {
    return execute(duration: duration, input: {
      "status": "RUNING_INST",
      "data": {"leftSec": _start, "spans": result}
    });
  }

  Future<void> moveIns(
      {required int duration, required Map<String, dynamic> player}) async {
    return execute(duration: duration, input: {
      "status": "MOVE_INS",
      "data": {
        "player": player,
        "span": {
          "point": {"x": 4, "y": 2},
          "length": 5,
          "vert": false
        }
      }
    });
  }

  Future<void> finalIns({required int duration, required int meDelta}) async {
    return execute(duration: duration, input: {
      "status": "FINAL_INS",
      "data": {
        "id": "1",
        "leading": "LV1",
        "meDelta": meDelta,
        "opponent": opponent.toUser(),
        "opponentDelta": meDelta * -1,
      }
    });
  }
}
