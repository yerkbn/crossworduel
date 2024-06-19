import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/button/custom_button.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      paddingHorizantal: 16.w,
      paddingVertical: 0,
      width: double.infinity,
      child: Column(
        children: [
          for (int i = 0; i < 6; i++) buildSelectItem(i),
          16.ph,
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

  Widget buildSelectItem(int index) {
    bool isActive = index == _index;
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return CustomContainer(
        paddingHorizantal: 0.w,
        topMargin: 8.h,
        width: double.infinity,
        height: 36.h,
        color: isActive ? theme.backgroundColor4 : theme.backgroundColor2,
        paddingVertical: 0.h,
        child: Align(
          alignment: Alignment.centerLeft,
          child: CustomContainer(
            color: isActive ? theme.backgroundColor4 : theme.backgroundColor3,
            topMargin: 0,
            paddingHorizantal: 0,
            paddingVertical: 4.h,
            borderRadius: 8.r,
            onPressed: () {
              setState(() {
                _index = index;
              });
            },
            width: 96.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("🇺🇸", style: theme.headline1.copyWith(fontSize: 20.sp)),
                6.pw,
                Text("ENG", style: theme.headline1)
              ],
            ),
          ),
        ));
  }
}
