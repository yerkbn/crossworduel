import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/config/ui/ui_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class CustomFullBottomSheet {
  static ModalBottomSheetRoute<T> buildRoute<T>({
    required Widget child,
    required BuildContext context,
    bool isDismissible = true,
    bool isScrollable = false,
  }) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return ModalBottomSheetRoute<T>(
      isScrollControlled: true,
      useSafeArea: true,
      modalBarrierColor: theme.backgroundColor2,
      // backgroundColor: theme.backgroundColor3,
      isDismissible: isDismissible,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (context) => Container(
        color: theme.backgroundColor2,
        child: Column(
          // alignment: Alignment.topCenter,
          children: [
            Container(
              // color: theme.backgroundColor2,
              // color: Colors.red,
              height: 45.h,
              width: UiConfig.globalWidth.w,
              alignment: Alignment.center,
              child: Container(
                width: 60.w,
                height: 5.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white60,
                ),
              ),
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
