import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/button/custom_button.dart';
import 'package:crossworduel/core/design-system/image/custom_local_image.dart';
import 'package:crossworduel/features/unauth/presentation/bloc/signin/signin_bloc.dart';
import 'package:crossworduel/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppleButton extends StatefulWidget {
  final SigninBloc signinBloc;
  const AppleButton({required this.signinBloc, super.key});

  @override
  State<AppleButton> createState() => _AppleButtonState();
}

class _AppleButtonState extends State<AppleButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return BlocBuilder<SigninBloc, SigninState>(
        bloc: widget.signinBloc,
        builder: (_, SigninState state) {
          final bool isLoading =
              state is LoadingSigninState && state.from == "APPLE";
          return CustomButton.h2(
            title: "",
            isLoading: isLoading,
            onPressed: () {
              if (!isLoading) {
                widget.signinBloc.add(const ActivateSigninEvent(from: "APPLE"));
              }
            },
            width: double.infinity,
            color: Colors.black,
            child: Row(
              children: [
                CustomLocalImageWidget(
                  image: Assets.icons.apple.path,
                  width: 20.h,
                  height: 20.h,
                ),
                SizedBox(width: 10.w),
                Text(
                  'Sign in with Apple',
                  style: theme.headline2.copyWith(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          );
        });
  }
}
