import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/design-system/image/custom_image.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/core/normalizer/normalizer.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/profile/domain/entities/user_entity.dart';
import 'package:crossworduel/navigation/auth_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProfileWidget extends StatelessWidget with Normalizer {
  final UserEntity user;
  final Color color;
  final double paddingHorizantal;
  final double height;
  final double imageSize;
  final int maxLength;
  final TextStyle? textStyle;
  final bool isProfileNavigationEnabled;

  CustomProfileWidget({
    super.key,
    required this.user,
    required this.color,
    this.isProfileNavigationEnabled = true,
    this.imageSize = 24,
    this.paddingHorizantal = 8,
    this.height = 36,
    this.maxLength = 9,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return CustomContainer(
        color: color,
        topMargin: 0,
        height: height.h,
        borderRadius: 6.h,
        paddingHorizantal: paddingHorizantal.w,
        paddingVertical: 0.h,
        onPressed: isProfileNavigationEnabled
            ? () {
                globalSL<AuthNavigation>()
                    .globalRouter
                    .push(AuthNavigation.profile, extra: user);
              }
            : null,
        child: Row(
          children: [
            CustomImageWidget(
              width: imageSize.h,
              height: imageSize.h,
              url: user.avatar,
              borderRadius: 6.h,
            ),
            6.pw,
            Text(
              normalizeString(user.getUsername(), maxLength: maxLength),
              style: textStyle ?? theme.headline2,
            ),
          ],
        ));
  }
}
