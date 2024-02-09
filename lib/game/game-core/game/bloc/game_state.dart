part of 'game_bloc.dart';

abstract class GameState extends Equatable {
  const GameState();
}

class LoadingGameState extends GameState {
  final PlayerEntity me; // the my personal data
  final PlayerEntity? opponent; // the oponent if not found it will be null

  const LoadingGameState({required this.me, this.opponent});
  @override
  List<Object> get props => [me, opponent ?? 1];
}

class FailureGameState extends GameState {
  final String error;

  const FailureGameState({required this.error});

  @override
  List<Object> get props => [error];
}

class RunningGameState extends GameState {
  final ParentAgent gameAgent;

  const RunningGameState({required this.gameAgent});

  @override
  List<Object> get props => [gameAgent];
}

class AFKGameState extends GameState {
  @override
  List<Object> get props => [];
}
