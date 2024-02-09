import 'package:crossworduel/game/game-core/sizer/sizer.dart';
import 'package:flutter/material.dart';

class ShadowAnimation extends AnimatedWidget {
  final Widget child;
  final Color color;

  const ShadowAnimation(
      {required this.child,
      required Animation<double> animation,
      required this.color})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    final double animationWidth = 10 * animation.value;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizer().getSp(4)),
        boxShadow: [
          BoxShadow(
              color: color,
              blurRadius: animationWidth,
              spreadRadius: animationWidth)
        ],
      ),
      child: child,
    );
  }
}
