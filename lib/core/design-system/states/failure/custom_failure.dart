import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum FailureStatus { h1, h2, h3 }

class CustomFailure extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Function()? onTap;
  final FailureStatus status;
  final String btnTitle;
  final String image;

  const CustomFailure({
    super.key,
    this.onTap,
    this.title = "Oops, unknown error, or internet problem",
    this.btnTitle = "Refresh",
    this.subtitle,
    this.status = FailureStatus.h1,
    this.image = "", //ImageAsset.error,
  });

  double get getHeight {
    if (status == FailureStatus.h2) return 20.h;
    if (status == FailureStatus.h3) return 40.h;
    return 80.h;
  }

  double get getFontSize {
    if (status == FailureStatus.h2) return 10.h;
    if (status == FailureStatus.h3) return 14.h;
    return 20.h;
  }

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Align(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: theme.backgroundColor3),
              width: getHeight,
              padding: EdgeInsets.all(12.h),
              child: Icon(Icons.connect_without_contact, size: 24.h),
            ),
            SizedBox(
              height: getFontSize,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.headline1.copyWith(
                fontSize: getFontSize,
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              subtitle ?? "Check your internet connection or refresh the page.",
              textAlign: TextAlign.center,
              style: theme.headline3
                  .copyWith(fontSize: getFontSize, color: Colors.black),
            ),
            SizedBox(
              height: 4.h,
            ),
            if (onTap == null)
              const SizedBox()
            else
              CustomButton.textBtn(
                title: btnTitle,
                onPressed: onTap!,
                color: theme.textColor2,
                fontSize: 14.h,
              )
          ],
        ),
      ),
    );
  }
}
