import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/game/game-core/agent/agent.dart';
import 'package:flutter/material.dart';

class GameTable extends StatefulWidget {
  final ParentAgent gameAgent;

  const GameTable({required this.gameAgent});
  @override
  State<StatefulWidget> createState() {
    return _GameTable();
  }
}

class _GameTable extends State<GameTable> {
  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return ColoredBox(
      color: theme.backgroundColor1,
      child: Stack(
        children: <Widget>[widget.gameAgent.build()],
      ),
    );
  }
}
