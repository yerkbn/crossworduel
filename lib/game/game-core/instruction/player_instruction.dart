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
  final PointEntity point;

  CrosswordTapInsD({
    required this.point,
    required Map objectMap,
  }) : super(insStatus, objectMap);

  factory CrosswordTapInsD.parseMap(Map objectMap) {
    return CrosswordTapInsD(
      point: objectMap.getValueSafely('point'),
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

class DeleteTapInsD extends InstructionData {
  static const String insStatus = 'DELETE_TAP';

  DeleteTapInsD({
    required Map objectMap,
  }) : super(insStatus, objectMap);

  factory DeleteTapInsD.parseMap(Map objectMap) {
    return DeleteTapInsD(
      objectMap: objectMap,
    );
  }
}

class NextPrevInsD extends InstructionData {
  final bool isNext;
  static const String insStatus = 'NEXT_PREV_TAP';

  NextPrevInsD({
    required this.isNext,
    required Map objectMap,
  }) : super(insStatus, objectMap);

  factory NextPrevInsD.parseMap(Map objectMap) {
    return NextPrevInsD(
        objectMap: objectMap, isNext: objectMap.getValueSafely("isNext"));
  }
}

class FinalInsD extends InstructionData {
  static const String insStatus = 'FINAL_INS';
  final FinalEntity finalEntity;

  FinalInsD({
    required Map objectMap,
    required this.finalEntity,
  }) : super(insStatus, objectMap);

  factory FinalInsD.parseMap(Map objectMap) {
    return FinalInsD(
        objectMap: objectMap, finalEntity: FinalEntity.parseMap(objectMap));
  }
}

class MoveInsD extends InstructionData with PlayerDriver {
  static const String insStatus = 'MOVE_INS';
  final SpanEntity span;

  MoveInsD({required Map objectMap, required this.span})
      : super(insStatus, objectMap) {
    parsePlayerEntityDriver(objectMap.getValueSafely('player'));
  }

  factory MoveInsD.parseMap(Map objectMap) {
    return MoveInsD(
        objectMap: objectMap,
        span: SpanEntity.parseMap(objectMap.getValueSafely('span')));
  }
}
