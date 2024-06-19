import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/image/custom_profile_widget.dart';
import 'package:crossworduel/core/design-system/label/label_widget.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/unauth/presentation/bloc/auth/auth_bloc.dart';
import 'package:crossworduel/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainAppBar extends PreferredSize {
  final bool withBack;
  MainAppBar({super.key, this.withBack = true})
      : super(
            preferredSize: Size(double.infinity, 54.h),
            child: MainAppBarBody(withBack: withBack));
}

class MainAppBarBody extends StatefulWidget {
  final bool withBack;
  const MainAppBarBody({super.key, required this.withBack});

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
              border:
                  Border(bottom: BorderSide(color: theme.backgroundColor3))),
          width: double.infinity,
          padding: EdgeInsets.only(right: ScreenUtil().setHeight(16)),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      if (widget.withBack)
                        SizedBox(
                            width: 50.w,
                            child: MaterialButton(
                                height: 48.h,
                                shape: const CircleBorder(),
                                onPressed: () => Navigator.pop(context),
                                child: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Colors.white,
                                )))
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
                        CustomProfileWidget(
                          color: theme.backgroundColor3,
                          username: "@yerkbn",
                          imageURL:
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQty1HQ79GVs19TXZ8MakAGjMCCHhvXH8XbHy-8spFeJw&s",
                        )
                    ],
                  ),
                  Expanded(child: SizedBox()),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LabelWidget(
                        text: "3",
                        imagePath: Assets.icons.fire.path,
                        height: 28,
                        paddingFactor: 1.2,
                        onPressed: () {},
                        color: theme.backgroundColor3,
                        borderColor: theme.backgroundColor3,
                      ),
                      6.pw,
                      LabelWidget(
                        text: "12",
                        imagePath: Assets.icons.heart.path,
                        height: 28,
                        paddingFactor: 1.2,
                        onPressed: () {},
                        color: theme.backgroundColor3,
                        borderColor: theme.backgroundColor3,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
