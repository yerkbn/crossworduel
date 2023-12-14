import 'package:crossworduel/game/core/agent/player_layer/ui/crossword/crossword_widget.dart';
import 'package:crossworduel/game/core/agent/player_layer/ui/crossword/hint_widget.dart';
import 'package:crossworduel/game/core/agent/player_layer/ui/keyboard/keyboard_widget.dart';
import 'package:crossworduel/game/core/agent/player_layer/ui/player/player_item.dart';
import 'package:crossworduel/game/core/agent/player_layer/ui/timer/game_timer.dart';
import 'package:crossworduel/game/core/agent/player_layer/ui/top-control/top_control_widget.dart';
import 'package:crossworduel/game/core/global_key/global_key.dart';
import 'package:crossworduel/game/core/sizer/sizer.dart';
import 'package:crossworduel/game/domain/entities/crossword_entity.dart';
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
  final GlobalKeyToIdManager<PlayerItemState, PlayerEntity> _players =
      GlobalKeyToIdManager([]);

  final GlobalKey<GameTimerState> _timer = GlobalKey<GameTimerState>();

  CrosswordEntity? _crossword;

  @override
  void initState() {
    super.initState();
    playerJoined(widget.currentPlayer);
  }

  void setCrossword(CrosswordEntity crossword) {
    setState(() {
      _crossword = crossword;
    });
  }

  void setLeftSec(int sec) {
    _timer.currentState!.runTimer(sec);
  }

  void playerJoined(PlayerEntity otherPlayer) {
    final GlobalKey<PlayerItemState> key = GlobalKey<PlayerItemState>();
    setState(() {
      _players.add(GlobalKeyToId(otherPlayer.id, key, otherPlayer));
    });
  }

  List<Widget> get _buildPlayers {
    final List<Widget> players = [];
    for (final GlobalKeyToId<PlayerItemState, PlayerEntity> globalKeyToId
        in _players.list) {
      final PlayerItem otherPlayerItem = PlayerItem(
          player: globalKeyToId.data,
          key: globalKeyToId.globalKey,
          isLeft: globalKeyToId.id == widget.currentPlayer.id);
      players.add(otherPlayerItem);
    }
    return players;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          TopControlWidget(timer: _timer),
          Container(
              margin: EdgeInsets.only(top: Sizer().getHeight(116)),
              width: Sizer().getHeight(327),
              height: Sizer().getHeight(44),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _buildPlayers,
              )),
          if (_crossword != null) CrosswordWidget(crossword: _crossword!),
          if (_crossword != null) HintWidget(hint: _crossword!.getHint.hint),
          if (_crossword != null) const KeyboardWidget(),
        ],
      ),
    );
  }
}
