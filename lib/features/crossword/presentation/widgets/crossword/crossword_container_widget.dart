import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/design-system/image/custom_profile_widget.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/core/normalizer/normalizer.dart';
import 'package:crossworduel/core/design-system/label/label_widget.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/crossword/domain/entities/crossword_entity.dart';
import 'package:crossworduel/gen/assets.gen.dart';
import 'package:crossworduel/navigation/auth_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CrosswordContainerWidget extends StatelessWidget with Normalizer {
  final bool isDetail;
  final CrosswordEntity crosswordEntity;
  const CrosswordContainerWidget(
      {super.key, this.isDetail = false, required this.crosswordEntity});

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return CustomContainer(
        topMargin: 8.h,
        borderRadius: 8.r,
        color: theme.backgroundColor3,
        onPressed: isDetail
            ? null
            : () {
                globalSL<AuthNavigation>()
                    .globalRouter
                    .push(AuthNavigation.detail);
              },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              crosswordEntity.title,
              style: theme.headline1,
            ),
            Text(
              normalizeString(crosswordEntity.description,
                  maxLength: isDetail ? 200 : 84, withDots: true),
              style: theme.headline4,
            ),
            6.ph,
            Row(
              children: [
                CustomProfileWidget(
                    imageURL:
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6ZQ5LAyl5s7REOUSWM96pzNWbj_QJ-cZ_6Q&s",
                    imageSize: 18,
                    height: 22,
                    paddingHorizantal: 0,
                    textStyle: theme.headline3,
                    username: "@thebanny",
                    color: theme.backgroundColor3),
                Expanded(child: 0.pw),
                LabelWidget(
                  text: "",
                  imagePath: Assets.icons.kz.path,
                ),
                2.pw,
                LabelWidget(
                  text: "6min",
                  imagePath: Assets.icons.timer.path,
                ),
                2.pw,
                LabelWidget(
                  text: "4.7",
                  imagePath: Assets.icons.star.path,
                ),
                2.pw,
                LabelWidget(
                  text: "2.4k",
                  imagePath: Assets.icons.people.path,
                ),
              ],
            )
          ],
        ));
  }
}
