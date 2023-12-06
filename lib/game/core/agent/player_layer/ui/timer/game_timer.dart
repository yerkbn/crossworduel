import 'dart:async';

import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GameTimer extends StatefulWidget {
  const GameTimer({required Key key}) : super(key: key);

  @override
  GameTimerState createState() => GameTimerState();
}

class GameTimerState extends State<GameTimer> {
  late Timer _timer;
  int _start = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void runTimer(int sec) {
    setState(() {
      _start = sec;
    });
    _timer.cancel();
    _startTimer();
  }

  void _startTimer() {
    const sec = Duration(seconds: 1);
    _timer = Timer.periodic(
      sec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Text(
      "$_start sec",
      style: theme.headline1.copyWith(fontSize: 18.sp),
    );
  }
}
