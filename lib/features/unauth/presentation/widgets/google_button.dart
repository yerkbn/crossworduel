import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/button/custom_button.dart';
import 'package:crossworduel/core/design-system/image/custom_local_image.dart';
import 'package:crossworduel/features/unauth/presentation/bloc/signin/signin_bloc.dart';
import 'package:crossworduel/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoogleButton extends StatefulWidget {
  final SigninBloc signinBloc;
  final void Function()? onPressed;
  const GoogleButton({required this.signinBloc, super.key, this.onPressed});

  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
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
              state is LoadingSigninState && state.from == "GOOGLE";
          return CustomButton.h1(
            title: "",
            isLoading: isLoading,
            textColor: theme.textColor1,
            isDisabled: false,
            onPressed: widget.onPressed ??
                () {
                  if (!isLoading) {
                    widget.signinBloc
                        .add(const ActivateSigninEvent(from: "GOOGLE"));
                  }
                },
            width: double.infinity,
            color: theme.backgroundColor3,
            child: Row(
              children: [
                CustomLocalImageWidget(
                  image: Assets.icons.google.path,
                  width: 20.h,
                  height: 20.h,
                ),
                SizedBox(width: 10.w),
                Text(
                  'Sign in with Google',
                  style: theme.headline2.copyWith(
                    fontSize: 14.sp,
                    color: theme.textColor1,
                  ),
                )
              ],
            ),
          );
        });
  }
}
