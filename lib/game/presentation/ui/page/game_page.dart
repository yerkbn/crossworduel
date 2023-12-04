import 'package:crossworduel/core/util/sizer/sizer.dart';
import 'package:crossworduel/game/presentation/ui/widget/crossword/crossword_widget.dart';
import 'package:crossworduel/game/presentation/ui/widget/top-control/top_control_widget.dart';
import 'package:crossworduel/game/presentation/ui/widget/users/top_users_widget.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    Sizer().init(context: context);
    return Scaffold(
        body: WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SizedBox(
        width: double.infinity,
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: Sizer().getHeight(gameHeight),
            child: const AspectRatio(
              aspectRatio: gameRatio,
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  TopControlWidget(),
                  TopUsersWidget(),
                  CrosswordWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
