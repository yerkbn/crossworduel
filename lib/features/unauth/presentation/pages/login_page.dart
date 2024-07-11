import 'dart:io';

import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/snack-bar/show_custom_snack_bar.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/features/unauth/presentation/bloc/signin/signin_bloc.dart';
import 'package:crossworduel/features/unauth/presentation/widgets/apple_button.dart';
import 'package:crossworduel/features/unauth/presentation/widgets/google_button.dart';
import 'package:crossworduel/features/unauth/presentation/widgets/terms_text.dart';
import 'package:crossworduel/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final SigninBloc _signinBloc = globalSL();

  @override
  void dispose() {
    _signinBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Scaffold(
      backgroundColor: theme.textColor1,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          36.ph,
          Container(
            width: double.infinity,
            height: 450.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.image.background.path),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(child: 0.ph),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: BlocListener<SigninBloc, SigninState>(
              bloc: _signinBloc,
              listener: (BuildContext _, state) {
                if (state is FailureSigninState) {
                  showCustomSnackBar(
                      context: context,
                      type: CustomSnackBarType.failure,
                      title: state.message);
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Crossword Duel",
                    style: theme.headline1.copyWith(
                        color: theme.backgroundColor1, fontSize: 36.sp),
                  ),
                  Text(
                    "Solve Crosswords, Create Your Own, Share the Fun, and Race to Victory",
                    style:
                        theme.headline3.copyWith(color: theme.backgroundColor1),
                  ),
                  24.ph,
                  GoogleButton(signinBloc: _signinBloc),
                  10.ph,
                  if (Platform.isAndroid)
                    0.ph
                  else
                    AppleButton(signinBloc: _signinBloc),
                  12.ph,
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: TermsPrivacyText(),
                  ),
                  36.ph,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
