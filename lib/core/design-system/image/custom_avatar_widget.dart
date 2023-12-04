import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/image/custom_outline_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAvatarWidget extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final double strokeWidth;
  final double levelFontSize;
  final Color color;
  final int currentLevel;

  const CustomAvatarWidget({
    super.key,
    required this.height,
    required this.width,
    required this.child,
    this.strokeWidth = 8.0,
    this.levelFontSize = 14.0,
    required this.color,
    required this.currentLevel,
  });

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return SizedBox(
      child: Stack(
        children: [
          CustomOutlineGradient(
            strokeWidth: strokeWidth,
            radius: 108.h,
            minHeight: height + strokeWidth,
            minWidth: width + strokeWidth,
            gradient: LinearGradient(
              colors: [color, color.withAlpha(100)],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
            child: child,
          ),
          Positioned(
            bottom: -2,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  color: theme.backgroundColor2,
                  borderRadius: BorderRadius.circular(24.h),
                ),
                child: Container(
                  height: (levelFontSize + levelFontSize * .2).h,
                  width: (width * 0.5).w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color, color.withOpacity(0.5)],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    borderRadius: BorderRadius.circular(24.h),
                  ),
                  child: Center(
                    child: Text(
                      '$currentLevel',
                      style: theme.headline1.copyWith(
                        color: Colors.white,
                        fontSize: levelFontSize.h,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
