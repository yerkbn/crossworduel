import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showCustomModalBottomSheet(BuildContext context, Widget child) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      final CustomThemeExtension theme = CustomThemeExtension.of(context);
      return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          color: theme.backgroundColor2,
        ),
        padding: EdgeInsets.only(bottom: 32.h, top: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.topCenter,
              width: 32.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 16.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.sp),
                color: theme.backgroundColor4,
              ),
            ),
            child,
          ],
        ),
      );
    },
  );
}
