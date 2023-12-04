import 'package:flutter/material.dart';

class CustomButtonWrapper extends StatelessWidget {
  final Widget child;
  final bool isCircle;
  final double borderRadius;
  final Function()? onPressed;
  final Color? color;
  final Color? foregroundColor;
  const CustomButtonWrapper({
    required this.child,
    required this.onPressed,
    this.color,
    this.foregroundColor,
    this.borderRadius = 0,
    this.isCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: isCircle
            ? const CircleBorder()
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        foregroundColor: foregroundColor ?? Colors.black12,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: color,
      ),
      child: child,
    );
  }
}
