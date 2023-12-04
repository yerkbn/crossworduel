import 'package:flutter/material.dart';

class CustomOutlineGradient extends StatelessWidget {
  final _GradientPainter _painter;
  final Widget _child;
  final double minWidth;
  final double minHeight;

  CustomOutlineGradient({
    required double strokeWidth,
    required double radius,
    required Gradient gradient,
    required Widget child,
    required this.minHeight,
    required this.minWidth,
  })  : _painter = _GradientPainter(strokeWidth: strokeWidth, radius: radius, gradient: gradient),
        _child = child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _painter,
      child: Container(
        constraints: BoxConstraints(minWidth: minWidth, minHeight: minHeight),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[_child],
        ),
      ),
    );
  }
}

class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  _GradientPainter({
    required this.strokeWidth,
    required this.radius,
    required this.gradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // create outer rectangle equals size
    final Rect outerRect = Offset.zero & size;
    final outerRRect = RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    final Rect innerRect = Rect.fromLTWH(
        strokeWidth, strokeWidth, size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    final innerRRect = RRect.fromRectAndRadius(innerRect, Radius.circular(radius - strokeWidth));

    // apply gradient shader
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    final Path path1 = Path()..addRRect(outerRRect);
    final Path path2 = Path()..addRRect(innerRRect);
    final path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
