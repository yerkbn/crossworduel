import 'package:crossworduel/game/domain/entities/player_entity.dart';
import 'package:flutter/material.dart';

class PlayersController extends StatefulWidget {
  final PlayerEntity currentPlayer;
  const PlayersController({
    required this.currentPlayer,
    required Key key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return PlayersControllerState();
  }
}

class PlayersControllerState extends State<PlayersController>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
