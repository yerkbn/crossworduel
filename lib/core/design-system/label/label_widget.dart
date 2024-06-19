import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabelWidget extends StatelessWidget {
  final String text;
  final double height;
  final double? width;
  final String? imagePath;
  final void Function()? onPressed;
  final Color? color;
  final Color? borderColor;
  final double paddingFactor;

  const LabelWidget({
    super.key,
    required this.text,
    this.imagePath,
    this.height = 20,
    this.paddingFactor = 1,
    this.width,
    this.onPressed,
    this.color,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return CustomContainer(
      height: height.h,
      width: width,
      borderRadius: 6.r,
      color: color ?? theme.backgroundColor4,
      borderColor: borderColor ?? theme.backgroundColor4,
      paddingHorizantal: 4.w * paddingFactor,
      onPressed: onPressed,
      paddingVertical: 0.h,
      topMargin: 0,
      child: Row(
        children: [
          if (imagePath != null)
            Image.asset(
              imagePath!,
              height: (height / (1.4 * paddingFactor)).h,
            ),
          if (text == "") 0.pw else if (imagePath != null) 4.pw,
          Text(text,
              style: theme.headline3
                  .copyWith(fontSize: (height / (1.6 * paddingFactor)).sp))
        ],
      ),
    );
  }
}
