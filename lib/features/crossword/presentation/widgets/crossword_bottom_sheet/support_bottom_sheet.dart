import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupportBottomSheet extends StatefulWidget {
  const SupportBottomSheet({super.key});

  @override
  State<SupportBottomSheet> createState() => _SupportBottomSheetState();
}

class _SupportBottomSheetState extends State<SupportBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return CustomContainer(
      paddingHorizantal: 16.w,
      paddingVertical: 0,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("SUPPORT COMMUNITY", style: theme.headline1),
          12.ph,
          buildSelectItem(Assets.icons.hearts.path, 25, "COMMUNITY SUPPORTER!"),
          buildSelectItem(
              Assets.icons.heartsBag.path, 200, "COMMUNITY CHAMPION!"),
          buildSelectItem(
              Assets.icons.heartsChest.path, 1000, "SAVER OF OUR COMMUNITY!"),
        ],
      ),
    );
  }

  Widget buildSelectItem(
    String imagePath,
    int heartAmount,
    String info,
  ) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return CustomContainer(
        color: theme.backgroundColor3,
        paddingVertical: 8,
        topMargin: 8,
        onPressed: () {},
        child: Row(
          children: [
            Image.asset(
              imagePath,
              height: 36.h,
            ),
            12.pw,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("$heartAmount HEART",
                    style: theme.headline1.copyWith(fontSize: 16.sp)),
                Text(info, style: theme.headline4.copyWith(fontSize: 12.sp)),
              ],
            ),
            Expanded(child: 0.pw),
            CustomContainer(
                paddingVertical: 6,
                color: theme.backgroundColor4,
                child: Text("\$0.99",
                    style: theme.headline1.copyWith(fontSize: 16.sp)))
          ],
        ));
  }
}
