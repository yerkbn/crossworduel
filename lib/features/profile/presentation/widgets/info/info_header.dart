import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoHeader extends StatelessWidget {
  final String title;
  final double titleFontSize;
  final String btnTitle;
  final void Function() onPressed;
  const InfoHeader({
    super.key,
    required this.title,
    this.titleFontSize = 16,
    required this.btnTitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title.toUpperCase(),
          style: theme.headline3
              .copyWith(color: theme.textColor2, fontSize: titleFontSize.h),
        ),
        TextButton(
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(
                  theme.primaryColor.withOpacity(.2))),
          onPressed: onPressed,
          child: Row(
            children: [
              Text(
                btnTitle,
                style: theme.headline3,
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: theme.primaryColor,
                size: 22.h,
              )
            ],
          ),
        )
      ],
    );
  }
}
