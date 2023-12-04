import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/button/custom_button_wrapper.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/navigation/unauth_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateAccountFirst extends StatelessWidget {
  const CreateAccountFirst({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: double.infinity,
        ),
        SizedBox(
          child: CustomButtonWrapper(
            color: theme.primaryColor.withOpacity(.2),
            onPressed: () {
              globalSL<UnauthNavigation>().goRouter.pop();
            },
            borderRadius: 100.r,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 32.h,
                  height: 32.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: theme.primaryColor.withOpacity(.15),
                      borderRadius: BorderRadius.circular(100.r)),
                  child: Icon(
                    Icons.person_add,
                    color: theme.primaryColor,
                    size: 18.h,
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Flexible(
                  child: Text(
                    "Сначала создайте аккаунт",
                    style: theme.headline1
                        .copyWith(fontSize: 17.h, color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
