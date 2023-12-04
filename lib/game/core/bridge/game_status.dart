import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/states/failure/custom_failure.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/navigation/auth_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GameStatus extends StatelessWidget {
  final String message;
  final String subtitle;
  final IconData icon;

  const GameStatus({
    required this.message,
    required this.icon,
    this.subtitle = "",
  });

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return ColoredBox(
      color: theme.backgroundColor1,
      child: Padding(
        padding: EdgeInsets.only(top: 154.h),
        child: CustomFailure(
          onTap: () {
            globalSL<AuthNavigation>().globalRouter.pop();
          },
          btnTitle: "Leave",
          title: message,
          subtitle: subtitle,
        ),
      ),
    );
  }
}
