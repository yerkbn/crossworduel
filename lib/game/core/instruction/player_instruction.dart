part of 'parent_instruction.dart';

class PlayerLeaveInsD extends InstructionData {
  static const String STATUS = 'PLAYER_LEAVE';
  final String playerId;
  PlayerLeaveInsD({required this.playerId, required Map objectMap})
      : super(STATUS, objectMap);

  static PlayerLeaveInsD parseMap(Map objectMap) {
    final PlayerLeaveInsD instance = PlayerLeaveInsD(
        playerId: objectMap.getValueSafely('playerId'), objectMap: objectMap);
    return instance;
  }
}
