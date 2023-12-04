import 'package:flutter/material.dart';

class CustomLocalImageWidget extends StatelessWidget {
  final String image;
  final double borderRadius;
  final double width;
  final double height;
  const CustomLocalImageWidget({
    super.key,
    required this.image,
    this.borderRadius = 0,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        width: width,
        height: height,
        child: Image.asset(image, fit: BoxFit.contain),
      ),
    );
  }
}
