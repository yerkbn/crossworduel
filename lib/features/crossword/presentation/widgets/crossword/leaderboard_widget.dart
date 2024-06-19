import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/design-system/image/custom_profile_widget.dart';
import 'package:crossworduel/core/design-system/label/label_widget.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaderboardWidget extends StatelessWidget {
  const LeaderboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Top players",
          style: theme.headline1,
        ),
        for (int i = 0; i < 5; i++)
          CustomContainer(
              topMargin: 8.h,
              color: (i % 2 == 0)
                  ? theme.backgroundColor3
                  : theme.backgroundColor2,
              paddingVertical: 2.h,
              borderRadius: 8.r,
              child: Row(
                children: [
                  LabelWidget(
                    text: (i + 1).toString(),
                    imagePath: Assets.icons.order.path,
                  ),
                  8.pw,
                  CustomProfileWidget(
                    color: Colors.transparent,
                    imageSize: 18,
                    maxLength: 12,
                    username: "@yerkbn",
                    imageURL:
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQty1HQ79GVs19TXZ8MakAGjMCCHhvXH8XbHy-8spFeJw&s",
                  ),
                  Expanded(child: 0.pw),
                  LabelWidget(
                    text: "32min",
                    imagePath: Assets.icons.timer.path,
                  ),
                ],
              )),
        42.ph,
      ],
    );
  }
}
