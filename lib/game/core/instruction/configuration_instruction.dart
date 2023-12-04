part of 'parent_instruction.dart';

/// Mixin to parse  currentPlayer data
mixin PlayerDriver {
  PlayerEntity? playerEntity;

  void parsePlayerEntityDriver(Map objectMap) {
    playerEntity = PlayerEntity.parseMap(objectMap);
  }

  static PlayerDriver? transformTo(dynamic smth) {
    if (smth is PlayerDriver) return smth;
    return null;
  }
}

/// Mixin to parse  all Players
mixin PlayersDriver {
  List<PlayerEntity>? players;

  void parsePlayersDriver(List<Map> items) {
    players = PlayerEntity.parseList(items);
  }

  static PlayersDriver? transformTo(dynamic smth) {
    if (smth is PlayersDriver) return smth;
    return null;
  }
}

/// This is instruction to the creator of the room
class RoomCreatedInsD extends InstructionData with PlayerDriver {
  static const String STATUS = 'ROOM_CREATED';
  final String roomId;

  RoomCreatedInsD({required this.roomId, required Map objectMap})
      : super(STATUS, objectMap) {
    parsePlayerEntityDriver(objectMap.getValueSafely('ownData'));
  }

  static RoomCreatedInsD parseMap(Map objectMap) {
    if (!objectMap.containsKey('roomId')) {
      throw ParsingExceptionInstr(
          objectMap: {'RoomCreatedInsD': "roomId is not found"});
    }
    return RoomCreatedInsD(
        roomId: objectMap.getValueSafely('roomId'), objectMap: objectMap);
  }
}

class AFKInsD extends InstructionData {
  static const String STATUS = 'UTIL_AFK';

  AFKInsD({required Map objectMap}) : super(STATUS, objectMap);

  static AFKInsD parseMap(Map objectMap) {
    return AFKInsD(objectMap: objectMap);
  }
}
