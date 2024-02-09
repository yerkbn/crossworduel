import 'package:crossworduel/game/domain/entities/final_entity.dart';
import 'package:crossworduel/game/game-core/agent/player_layer/ui/crossword/crossword_widget.dart';
import 'package:crossworduel/game/game-core/agent/player_layer/ui/crossword/hint_widget.dart';
import 'package:crossworduel/game/game-core/agent/player_layer/ui/final/final_result_widget.dart';
import 'package:crossworduel/game/game-core/agent/player_layer/ui/keyboard/keyboard_widget.dart';
import 'package:crossworduel/game/game-core/agent/player_layer/ui/player/player_item.dart';
import 'package:crossworduel/game/game-core/agent/player_layer/ui/timer/game_timer.dart';
import 'package:crossworduel/game/game-core/agent/player_layer/ui/top-control/top_control_widget.dart';
import 'package:crossworduel/game/game-core/crossword/entity/span_entity.dart';
import 'package:crossworduel/game/game-core/global_key/global_key.dart';
import 'package:crossworduel/game/game-core/sizer/sizer.dart';
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

  FinalEntity? _finalEntity;

  @override
  void initState() {
    super.initState();
    playerUpdate(widget.currentPlayer);
  }

  void setCrossword(CrosswordEntity crossword) {
    setState(() {
      _crossword = crossword;
    });
  }

  void setFinal(FinalEntity value) {
    setState(() {
      _finalEntity = value;
    });
  }

  void setLeftSec(int sec) {
    _timer.currentState!.runTimer(sec);
  }

  /// When player make move it was correct move we will light up
  /// GREEN - if it was correct
  void lightUp({required String id, required SpanEntity span}) {
    _players.findById(id).globalKey.currentState!.lightUp(span);
  }

  void playerUpdate(PlayerEntity player) {
    final GlobalKey<PlayerItemState> key = GlobalKey<PlayerItemState>();

    setState(() {
      _players.replaceOrAdd(GlobalKeyToId(player.id, key, player));
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
          if (_crossword != null && _crossword!.getActiveSpan != null)
            HintWidget(span: _crossword!.getActiveSpan!),
          if (_crossword != null) KeyboardWidget(crossword: _crossword!),
          if (_finalEntity != null)
            FinalResultWidget(finalEntity: _finalEntity!)
        ],
      ),
    );
  }
}
