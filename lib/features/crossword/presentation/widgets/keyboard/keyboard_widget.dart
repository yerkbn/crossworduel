import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KeyboardWidget extends StatelessWidget {
  final void Function(String letter) onKeyboardTap;
  final void Function() onDelete;
  const KeyboardWidget({
    super.key,
    required this.onKeyboardTap,
    required this.onDelete,
  });

  void _triggerLightImpact() {
    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 345.w,
        height: 200.h,
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _buildLetter(context, "Q"),
              _buildLetter(context, "W"),
              _buildLetter(context, "E"),
              _buildLetter(context, "R"),
              _buildLetter(context, "T"),
              _buildLetter(context, "Y"),
              _buildLetter(context, "U"),
              _buildLetter(context, "I"),
              _buildLetter(context, "O"),
              _buildLetter(context, "P"),
            ]),
            4.ph,
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _buildLetter(context, "A"),
              _buildLetter(context, "S"),
              _buildLetter(context, "D"),
              _buildLetter(context, "F"),
              _buildLetter(context, "G"),
              _buildLetter(context, "H"),
              _buildLetter(context, "J"),
              _buildLetter(context, "K"),
              _buildLetter(context, "L"),
            ]),
            4.ph,
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _buildLetter(context, "+"),
              _buildLetter(context, "Z"),
              _buildLetter(context, "X"),
              _buildLetter(context, "C"),
              _buildLetter(context, "V"),
              _buildLetter(context, "B"),
              _buildLetter(context, "N"),
              _buildLetter(context, "M"),
              _buildLetter(context, "<=", onTap: () {
                _triggerLightImpact();
                onDelete();
              }),
            ]),
          ],
        ));
  }

  Widget _buildLetter(BuildContext context, String letter,
      {Function()? onTap}) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return CustomContainer(
      width: 30,
      height: 54,
      topMargin: 0,
      leftMargin: 2,
      rightMargin: 2,
      onPressed: onTap ??
          () {
            _triggerLightImpact();
            onKeyboardTap(letter);
          },
      borderRadius: 6.w,
      color: theme.backgroundColor3,
      paddingSize: 0,
      child: Text(letter.toUpperCase(),
          style: theme.headline2.copyWith(
            color: theme.textColor1,
            fontSize: 14.sp,
          )),
    );
  }
}
