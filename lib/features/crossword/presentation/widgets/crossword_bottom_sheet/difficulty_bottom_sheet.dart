import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/button/custom_button.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/design-system/label/label_widget.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DifficultyBottomSheet extends StatefulWidget {
  const DifficultyBottomSheet({super.key});

  @override
  State<DifficultyBottomSheet> createState() => _DifficultyBottomSheetState();
}

class _DifficultyBottomSheetState extends State<DifficultyBottomSheet> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return CustomContainer(
      paddingHorizantal: 16.w,
      paddingVertical: 0,
      width: double.infinity,
      child: Column(
        children: [
          buildSelectItem(0, "EASY", theme.greenLightColor,
              theme.greenHardColor, theme.textColor1),
          buildSelectItem(1, "MEDIUM", theme.blueLightColor,
              theme.blueHardColor, theme.textColor1),
          buildSelectItem(2, "HARD", theme.redLightColor, theme.redHardColor,
              theme.textColor1),
          8.ph,
          CustomButton.h2(
            title: "SAVE",
            width: 132.w,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: Assets.icons.pen.image(height: 22.h),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSelectItem(
    int index,
    String text,
    Color backgroundColor,
    Color borderColor,
    Color textColor,
  ) {
    bool isActive = index == _index;
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: LabelWidget(
          width: isActive ? double.infinity : 86,
          text: text,
          height: 32,
          paddingFactor: 1.2,
          onPressed: () {
            setState(() => _index = index);
          },
          color: backgroundColor,
          borderColor: borderColor,
        ),
      ),
    );
  }
}
