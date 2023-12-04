import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/button/custom_button_wrapper.dart';
import 'package:crossworduel/core/design-system/image/custom_avatar_widget.dart';
import 'package:crossworduel/core/design-system/image/custom_image.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/unauth/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainAppBar extends PreferredSize {
  final bool withBack;
  final Function onLeadingTap;
  MainAppBar({super.key, this.withBack = true, required this.onLeadingTap})
      : super(
          preferredSize: Size(double.infinity, 64.h),
          child: MainAppBarBody(withBack: withBack, onLeadingTap: onLeadingTap),
        );
}

class MainAppBarBody extends StatefulWidget {
  final bool withBack;
  final Function onLeadingTap;
  const MainAppBarBody(
      {super.key, required this.withBack, required this.onLeadingTap});

  @override
  State<StatefulWidget> createState() => _MainAppBarBody();
}

class _MainAppBarBody extends State<MainAppBarBody> {
  final bool isNotAuthenticated = globalSL<AuthBloc>().currentUser == null;
  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return ColoredBox(
      color: theme.backgroundColor2,
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: theme.backgroundColor2,
            border: Border(bottom: BorderSide(color: theme.backgroundColor4)),
          ),
          width: double.infinity,
          height: ScreenUtil().setHeight(230),
          padding: EdgeInsets.only(right: ScreenUtil().setHeight(16)),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (widget.withBack)
                      SizedBox(
                        width: 50.w,
                        child: MaterialButton(
                          height: 50.h,
                          shape: const CircleBorder(),
                          onPressed: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                          ),
                        ),
                      )
                    else
                      SizedBox(width: 16.w),
                    if (isNotAuthenticated)
                      Text(
                        'v1.util.main',
                        style: theme.headline1.copyWith(
                          color: Colors.white,
                          fontSize: 21.h,
                        ),
                      )
                    else
                      CustomButtonWrapper(
                        onPressed: () {},
                        child: CustomAvatarWidget(
                          height: 44.h,
                          width: 44.h,
                          strokeWidth: 3,
                          levelFontSize: 10,
                          color: Colors.red,
                          currentLevel: 1,
                          child: CustomImageWidget(
                            url:
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQty1HQ79GVs19TXZ8MakAGjMCCHhvXH8XbHy-8spFeJw&s",
                            borderRadius: 48.h,
                            width: 44.h,
                            height: 44.h,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
