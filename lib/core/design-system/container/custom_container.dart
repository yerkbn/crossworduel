import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/button/custom_button_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final double? paddingVertical;
  final double? paddingHorizantal;
  final double? paddingSize;
  final Color? color;
  final Color? borderColor;
  final double? width;
  final double? height;
  final double minHeight;
  final double topMargin;
  final double borderRadius;
  final void Function()? onPressed;
  final BoxConstraints? constraints;

  const CustomContainer({
    super.key,
    required this.child,
    this.color,
    this.borderColor,
    this.onPressed,
    this.width,
    this.height,
    this.minHeight = 0,
    this.topMargin = 8,
    this.paddingHorizantal,
    this.paddingSize,
    this.borderRadius = 12,
    this.paddingVertical,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    Widget resultChild = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: paddingSize ?? paddingHorizantal ?? 16.h,
        vertical: paddingSize ?? paddingVertical ?? 16.h,
      ),
      child: child,
    );
    if (onPressed != null) {
      resultChild = CustomButtonWrapper(
        onPressed: onPressed,
        borderRadius: borderRadius.h,
        child: resultChild,
      );
    }
    return Container(
      width: width ?? double.infinity,
      height: height,
      constraints: constraints ?? BoxConstraints(minHeight: minHeight.h),
      margin: EdgeInsets.only(top: topMargin.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius.h),
        color: color ?? theme.backgroundColor2,
        border: borderColor == null ? null : Border.all(color: borderColor!),
      ),
      child: resultChild,
    );
  }
}
