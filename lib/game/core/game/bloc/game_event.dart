part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
}

/// This is new concept
/// here all event comming from server or from
/// UI will be transfered with this class
class RunGameEvent extends GameEvent {
  final InstructionData instruction;
  const RunGameEvent({required this.instruction});

  bool get isLocal => instruction.isLocal;
  @override
  List<Object> get props => [instruction];
}

class LoadingGameEvent extends GameEvent {
  final PlayerEntity? me;
  final PlayerEntity? opponent;

  const LoadingGameEvent({this.me, this.opponent});
  @override
  List<Object> get props => [];
}

class ReconnectGameEvent extends GameEvent {
  @override
  List<Object> get props => [];
}

class FailureGameEvent extends GameEvent {
  final String error;
  const FailureGameEvent({required this.error});

  @override
  List<Object> get props => [error];
}

class AFKGameEvent extends GameEvent {
  @override
  List<Object> get props => [];
}

/// This instructions is trigered by player
/// And it will be send to server by getter [generateServerMessage]
/// further will be chained by [generateInstruction] to current UI
abstract class LocalGameEvent extends GameEvent {
  final bool
      isLocal; // to differentiate does we need to send this event to server or not

  const LocalGameEvent({this.isLocal = false});

  String get getId; // It will be used inside Request limmitter
  int get getDuration;

  @override
  List<Object> get props => [];

  String get generateServerMessage {
    return generateServerMessageFromMap(generateServerMap);
  }

  static String generateServerMessageFromMap(Map map) {
    return json.encode(map);
  }

  InstructionData get generateInstruction;
  Map get generateServerMap;
}

/// When player leave game page this
/// method will be called no notify server
/// about it
class PlayerLeaveGameEvent extends LocalGameEvent {
  final String status = 'PLAYER_LEAVE';
  final String playerId;

  const PlayerLeaveGameEvent({required this.playerId});

  @override
  Map get generateServerMap {
    return {
      'status': status,
      'data': {'playerId': playerId}
    };
  }

  @override
  InstructionData get generateInstruction =>
      RoomCreatedInsD(objectMap: {}, roomId: '');

  @override
  List<Object> get props => [playerId];

  @override
  int get getDuration => 0;

  @override
  String get getId => status;
}
