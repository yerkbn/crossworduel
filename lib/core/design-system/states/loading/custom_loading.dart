import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLoading extends StatelessWidget {
  final double progresHeight;
  final double strokeWidth;
  final Color color;
  final double padding;
  const CustomLoading(
      {super.key,
      this.progresHeight = 24,
      this.color = Colors.grey,
      this.padding = 10,
      this.strokeWidth = 3});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(padding.h),
        child: SizedBox(
            height: progresHeight.h,
            width: progresHeight.h,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                color,
              ),
              strokeWidth: strokeWidth,
            )),
      ),
    );
  }
}
