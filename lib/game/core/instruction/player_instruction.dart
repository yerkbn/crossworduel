part of 'parent_instruction.dart';

class PlayerLeaveInsD extends InstructionData {
  static const String insStatus = 'PLAYER_LEAVE';
  final String playerId;
  PlayerLeaveInsD({required this.playerId, required Map objectMap})
      : super(insStatus, objectMap);

  factory PlayerLeaveInsD.parseMap(Map objectMap) {
    final PlayerLeaveInsD instance = PlayerLeaveInsD(
        playerId: objectMap.getValueSafely('playerId'), objectMap: objectMap);
    return instance;
  }
}

/// This is instruction to the creator of the room
class PlayerFoundInsD extends InstructionData with PlayersDriver {
  static const String insStatus = 'PLAYER_FOUND';

  PlayerFoundInsD({required Map objectMap}) : super(insStatus, objectMap) {
    final List items = objectMap.getValueSafely('players');
    parsePlayersDriver(items);
  }

  factory PlayerFoundInsD.parseMap(Map objectMap) {
    return PlayerFoundInsD(objectMap: objectMap);
  }
}

///Running instruction
///question with time will be given
class RunningInsD extends InstructionData {
  static const String insStatus = 'RUNING_INST';
  final int leftSec;
  final CrosswordEntity crossword;

  RunningInsD({
    required this.leftSec,
    required this.crossword,
    required Map objectMap,
  }) : super(insStatus, objectMap);

  factory RunningInsD.parseMap(Map objectMap) {
    return RunningInsD(
      leftSec: objectMap.getValueSafely('leftSec'),
      crossword: CrosswordEntity.parseMap(objectMap),
      objectMap: objectMap,
    );
  }
}

class CrosswordTapInsD extends InstructionData {
  static const String insStatus = 'CROSSWORD_TAP';
  final int index;

  CrosswordTapInsD({
    required this.index,
    required Map objectMap,
  }) : super(insStatus, objectMap);

  factory CrosswordTapInsD.parseMap(Map objectMap) {
    return CrosswordTapInsD(
      index: objectMap.getValueSafely('index'),
      objectMap: objectMap,
    );
  }
}

class KeyboardTapInsD extends InstructionData {
  static const String insStatus = 'KEYBOARD_TAP';
  final String letter;

  KeyboardTapInsD({
    required this.letter,
    required Map objectMap,
  }) : super(insStatus, objectMap);

  factory KeyboardTapInsD.parseMap(Map objectMap) {
    return KeyboardTapInsD(
      letter: objectMap.getValueSafely('letter'),
      objectMap: objectMap,
    );
  }
}
