import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/design-system/label/label_widget.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/unauth/presentation/bloc/auth/auth_bloc.dart';
import 'package:crossworduel/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CrosswordAppBar extends PreferredSize {
  CrosswordAppBar({super.key})
      : super(
            preferredSize: Size(double.infinity, 54.h),
            child: CrosswordAppBarBody());
}

class CrosswordAppBarBody extends StatefulWidget {
  const CrosswordAppBarBody({super.key});

  @override
  State<StatefulWidget> createState() => _CrosswordAppBarBody();
}

class _CrosswordAppBarBody extends State<CrosswordAppBarBody> {
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
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LabelWidget(
                    text: "12 sec",
                    imagePath: Assets.icons.timer.path,
                    height: 32,
                    paddingFactor: 1.2,
                    onPressed: () {},
                    color: theme.backgroundColor3,
                    borderColor: theme.backgroundColor3,
                  ),
                  Expanded(child: 0.pw),
                  LabelWidget(
                    text: "12",
                    imagePath: Assets.icons.heart.path,
                    height: 32,
                    paddingFactor: 1.2,
                    onPressed: () {},
                    color: theme.backgroundColor3,
                    borderColor: theme.backgroundColor3,
                  ),
                  6.pw,
                  CustomContainer(
                    color: theme.backgroundColor3,
                    paddingHorizantal: 5.h,
                    paddingVertical: 5.h,
                    topMargin: 0,
                    borderRadius: 8.h,
                    child: Icon(
                      Icons.block,
                      color: Colors.white,
                      size: 24.h,
                    ),
                    onPressed: () {},
                  ),
                  6.pw,
                  CustomContainer(
                    color: theme.backgroundColor3,
                    paddingHorizantal: 5.h,
                    paddingVertical: 5.h,
                    topMargin: 0,
                    borderRadius: 8.h,
                    child: Icon(
                      Icons.ios_share_outlined,
                      color: Colors.white,
                      size: 24.h,
                    ),
                    onPressed: () {},
                  ),
                  6.pw,
                  CustomContainer(
                    color: theme.backgroundColor3,
                    paddingHorizantal: 5.h,
                    paddingVertical: 5.h,
                    topMargin: 0,
                    borderRadius: 8.h,
                    child: Icon(
                      Icons.pause,
                      color: Colors.white,
                      size: 24.h,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
