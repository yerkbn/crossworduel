import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/config/ui/ui_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum CustomSnackBarType { success, failure, warning }

extension CustomSnackBarColor on CustomSnackBarType {
  Color get getColor {
    switch (this) {
      case CustomSnackBarType.success:
        return Colors.green;
      case CustomSnackBarType.failure:
        return const Color(0xFFF44336);
      case CustomSnackBarType.warning:
        return Colors.orange;
      default:
        return Colors.white;
    }
  }
}

void showCustomSnackBar({
  required BuildContext context,
  required CustomSnackBarType type,
  required String title,
}) {
  final CustomThemeExtension theme = CustomThemeExtension.of(context);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        title,
        style: theme.headline3.copyWith(color: type.getColor),
        maxLines: 1,
      ),
      duration: const Duration(milliseconds: 1500),
      width: UiConfig.globalWidth.w - 50,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: theme.backgroundColor4,
    ),
  );
}
