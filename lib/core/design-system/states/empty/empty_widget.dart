import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyWidget extends StatelessWidget {
  final void Function()? onTap;

  const EmptyWidget({
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
              size: 42.h,
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              "Бірінші боп қос!",
              textAlign: TextAlign.center,
              style: theme.headline2,
            ),
            SizedBox(
              height: 8.h,
            ),
            if (onTap == null)
              Container()
            else
              CustomButton.h2(title: "", width: 327.w, onPressed: onTap!)
          ],
        ),
      ),
    );
  }
}
