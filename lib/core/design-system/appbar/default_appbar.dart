import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/config/ui/ui_config.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/unauth/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultAppBar extends PreferredSize {
  final String title;
  final Widget? rightWidget;
  final Function()? onLeadingTap;
  final IconData? backIcon;
  final bool isBottomLineEnabled;

  DefaultAppBar({
    super.key,
    required this.title,
    this.onLeadingTap,
    this.rightWidget,
    this.backIcon,
    this.isBottomLineEnabled = true,
  }) : super(
          preferredSize: Size(double.infinity, 54.h),
          child: DefaultAppBarBody(
            title: title,
            isBottomLineEnabled: isBottomLineEnabled,
            rightWidget: rightWidget,
            onLeadingTap: onLeadingTap,
            backIcon: backIcon,
          ),
        );
}

class DefaultAppBarBody extends StatefulWidget {
  final String title;
  final bool isBottomLineEnabled;
  final Widget? rightWidget;
  final Function()? onLeadingTap;
  final IconData? backIcon;

  const DefaultAppBarBody({
    super.key,
    required this.title,
    required this.isBottomLineEnabled,
    this.onLeadingTap,
    this.rightWidget,
    this.backIcon,
  });

  @override
  State<StatefulWidget> createState() => _DefaultAppBarBody();
}

class _DefaultAppBarBody extends State<DefaultAppBarBody> {
  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return ColoredBox(
      color: theme.backgroundColor2,
      child: Container(
        decoration: BoxDecoration(
          color: theme.backgroundColor2,
          border: widget.isBottomLineEnabled
              ? Border(bottom: BorderSide(color: theme.backgroundColor4))
              : null,
        ),
        width: double.infinity,
        height: UiConfig.globalAppbarHeight.h,
        padding: EdgeInsets.only(right: 16.w),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: BlocBuilder<AuthBloc, AuthState>(
            bloc: globalSL<AuthBloc>(),
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (widget.onLeadingTap == null)
                        24.pw
                      else
                        SizedBox(
                          width: 50.w,
                          child: MaterialButton(
                            height: 50.h,
                            shape: const CircleBorder(),
                            onPressed: widget.onLeadingTap,
                            child: Icon(
                              widget.backIcon ??
                                  Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      Text(
                        widget.title,
                        style: theme.headline1.copyWith(
                          color: Colors.white,
                          fontSize: 20.h,
                        ),
                      ),
                      50.ph,
                    ],
                  ),
                  Expanded(child: 0.pw),
                  if (widget.rightWidget != null)
                    widget.rightWidget!
                  else
                    const SizedBox.shrink(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
