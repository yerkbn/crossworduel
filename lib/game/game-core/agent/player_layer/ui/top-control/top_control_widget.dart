import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/game/game-core/agent/player_layer/ui/timer/game_timer.dart';
import 'package:crossworduel/game/game-core/sizer/sizer.dart';
import 'package:crossworduel/navigation/auth_navigation.dart';
import 'package:flutter/material.dart';

class TopControlWidget extends StatefulWidget {
  final GlobalKey<GameTimerState> timer;
  const TopControlWidget({super.key, required this.timer});

  @override
  State<TopControlWidget> createState() => _TopControlWidgetState();
}

class _TopControlWidgetState extends State<TopControlWidget> {
  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Container(
      margin: EdgeInsets.only(top: Sizer().getHeight(62)),
      // color: Colors.black,
      width: Sizer().getHeight(327),
      height: Sizer().getHeight(36),
      child: Row(
        children: [
          CustomContainer(
              width: Sizer().getHeight(36),
              height: Sizer().getHeight(36),
              paddingSize: 0,
              topMargin: 0,
              borderRadius: Sizer().getSp(4),
              color: theme.backgroundColor3,
              onPressed: () {
                globalSL<AuthNavigation>().globalRouter.pop();
              },
              child: Icon(
                Icons.close,
                color: theme.textColor1,
                size: Sizer().getSp(20),
              )),
          12.pw,
          CustomContainer(
              width: Sizer().getHeight(36),
              height: Sizer().getHeight(36),
              paddingSize: 0,
              topMargin: 0,
              borderRadius: Sizer().getSp(4),
              color: theme.backgroundColor3,
              onPressed: () {},
              child: Icon(
                Icons.record_voice_over_outlined,
                color: theme.textColor1,
                size: Sizer().getSp(20),
              )),
          12.pw,
          CustomContainer(
              width: Sizer().getHeight(36),
              height: Sizer().getHeight(36),
              paddingSize: 0,
              topMargin: 0,
              borderRadius: Sizer().getSp(4),
              color: theme.backgroundColor3,
              onPressed: () {},
              child: Icon(
                Icons.dark_mode,
                color: theme.textColor1,
                size: Sizer().getSp(20),
              )),
          12.pw,
          GameTimer(key: widget.timer)
        ],
      ),
    );
  }
}
