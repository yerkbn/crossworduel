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

  void parsePlayersDriver(List items) {
    players = PlayerEntity.parseList(items);
  }

  static PlayersDriver? transformTo(dynamic smth) {
    if (smth is PlayersDriver) return smth;
    return null;
  }

  PlayerEntity getFirstOponent({required String currentPlayerId}) {
    if (_listNotEmpty) {
      for (final PlayerEntity player in players!) {
        if (player.id != currentPlayerId) return player;
      }
    }
    throw ParsingExceptionInstr(
        objectMap: {"PlayersDriver": "oponent not found $players"});
  }

  PlayerEntity getById({required String id}) {
    if (_listNotEmpty) {
      for (final PlayerEntity player in players!) {
        if (player.id == id) return player;
      }
    }
    throw ParsingExceptionInstr(
        objectMap: {"PlayersDriver": "id not found $id players = $players"});
  }

  bool get _listNotEmpty {
    if (players == null) {
      throw ParsingExceptionInstr(
          objectMap: {"PlayersDriver": "players list is null  $players"});
    }
    if (players!.length < 2) {
      throw ParsingExceptionInstr(objectMap: {
        "PlayersDriver": "players length is smaller than 2  $players"
      });
    }
    return true;
  }
}

/// This is instruction to the creator of the room
class RoomCreatedInsD extends InstructionData with PlayerDriver {
  static const String insStatus = 'ROOM_CREATED';
  final String roomId;

  RoomCreatedInsD({required this.roomId, required Map objectMap})
      : super(insStatus, objectMap) {
    parsePlayerEntityDriver(objectMap.getValueSafely('me'));
  }

  factory RoomCreatedInsD.parseMap(Map objectMap) {
    if (!objectMap.containsKey('roomId')) {
      throw ParsingExceptionInstr(
          objectMap: {'RoomCreatedInsD': "roomId is not found"});
    }
    return RoomCreatedInsD(
        roomId: objectMap.getValueSafely('roomId'), objectMap: objectMap);
  }
}

class AFKInsD extends InstructionData {
  static const String insStatus = 'UTIL_AFK';

  AFKInsD({required Map objectMap}) : super(insStatus, objectMap);

  factory AFKInsD.parseMap(Map objectMap) {
    return AFKInsD(objectMap: objectMap);
  }
}
