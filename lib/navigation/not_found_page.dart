import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/button/custom_button.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/navigation/auth_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Padding(
          //   padding: EdgeInsets.all(24.h),
          //   child: Image.asset(
          //     ImageAsset.error,
          //     width: 80.h,
          //     height: 80.h,
          //   ),
          // ),
          Text(
            'This page Not found',
            style: theme.headline1,
          ),
          SizedBox(
            height: 24.h,
          ),
          SizedBox(
            width: 224.w,
            child: CustomButton.textBtn(
              title: "Go Back Home",
              onPressed: () {
                globalSL<AuthNavigation>().globalRouter.go(
                      AuthNavigation.main,
                    );
              },
              color: Colors.red,
            ),
          ),
        ],
      )),
    );
  }
}
