import 'package:crossworduel/game/domain/entities/player_entity.dart';
import 'package:crossworduel/game/game-core/crossword/crossoword_picker_manager.dart';
import 'package:crossworduel/game/game-core/mock/mock.dart';
import 'package:crossworduel/game/game-core/mock/mock_game/mock_instruction.dart';

class MockGame extends MockParent {
  final MockCore core;
  final MockInstructionMapper _instrtructionMapper = MockInstructionMapper();
  // local state
  late CrosswordPickerManager _picker;
  late List<Map<String, dynamic>> _currentCrossword;

  late PlayerEntity me = PlayerEntity(
      id: cpId,
      avatar: "https://shoq.ai:4002/studimage/default/small/8.jpg",
      username: "yerkebulan",
      point: 1244,
      progressPoint: 0);
  late PlayerEntity opponent = PlayerEntity(
      id: "2",
      avatar: "https://shoq.ai:4002/studimage/default/small/1.jpg",
      username: "elonmusk",
      point: 1244,
      progressPoint: 0);

  int meCorrectCnt = 0;
  int opponentCorrectCnt = 0;

  MockGame(super.config) : core = MockCore(config);

  @override
  void runTest() {
    super.runTest();
    _init();
  }

  @override
  void add(String message) {
    final MockInstructionData instruction = _instrtructionMapper.parse(message);
    if (instruction is MoveMockInsD) {
      if (_currentCrossword.length == instruction.correctCnt) {
        meCorrectCnt = instruction.correctCnt;
        me = me.copyWith(
            progressPoint: me.progressPoint + 50, point: me.point + 5);
        finalIns(duration: 0, winnerId: me.id, delta: 5);
      } else if (instruction.correctCnt > meCorrectCnt) {
        meCorrectCnt = instruction.correctCnt;
        me = me.copyWith(progressPoint: me.progressPoint + 50);
        moveIns(duration: 0, player: me.toJson());
      }
    }
  }

  Future<void> _init() async {
    roomCreated(duration: 0, me: me.toJson());
    _picker = await CrosswordPickerManager.create();
    Future.delayed(const Duration(milliseconds: 100));
    playerFound(duration: 0, opponent: opponent.toJson(), me: me.toJson());
    Future.delayed(const Duration(milliseconds: 200));
    _currentCrossword = _picker.pick();
    running(duration: 0, result: _currentCrossword);
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
      "data": {"leftSec": 300, "spans": result}
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

  Future<void> finalIns(
      {required int duration,
      required String winnerId,
      required int delta}) async {
    return execute(duration: duration, input: {
      "status": "FINAL_INS",
      "data": (
        id: "1",
        leading: "LVL1",
        meDelta: me.toJson(),
        opponent: opponent.toJson(),
        opponentDelta: 3,
      )
    });
  }
}
