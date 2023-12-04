import 'package:crossworduel/game/domain/entities/player_entity.dart';

/// Players Holders
/// This needed for mostly agents
/// in order to pass only this holder
class PlayerStatesHolder {
  final PlayerEntity _currentPlayer;
  PlayerEntity? _opponentPlayer;

  PlayerStatesHolder({required PlayerEntity currentPlayer})
      : _currentPlayer = currentPlayer;

  set setOpponentPlayer(PlayerEntity player) => _opponentPlayer = player;
  PlayerEntity get getCurrentPlayer => _currentPlayer;
  PlayerEntity? get getOpponentPlayers => _opponentPlayer;
  bool get isOpponentExist => _opponentPlayer != null;
}
