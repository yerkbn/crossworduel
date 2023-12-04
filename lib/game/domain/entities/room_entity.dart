class RoomCreateEntity {
  final String subjectId;
  final String? playerId;

  RoomCreateEntity({
    required this.subjectId,
    this.playerId,
  });
}

/// When user start game, we give it to GameBloc
class RoomEntity {
  final String? roomId;
  final RoomCreateEntity? createRoom;

  RoomEntity({
    this.roomId,
    this.createRoom,
  });
}
