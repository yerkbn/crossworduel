import 'dart:io';

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Assets.image.background.path),
              fit: BoxFit.cover,
              colorFilter:
                  const ColorFilter.mode(Colors.black54, BlendMode.darken)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BlocListener<SigninBloc, SigninState>(
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
                  children: [
                    // DevUrlWidget(),
                    12.ph,
                    GoogleButton(signinBloc: _signinBloc),
                    10.ph,
                    if (Platform.isAndroid)
                      0.ph
                    else
                      AppleButton(signinBloc: _signinBloc),
                  ],
                ),
              ),
              12.ph,
              const Align(
                alignment: Alignment.bottomCenter,
                child: TermsPrivacyText(),
              ),
              64.ph,
            ],
          ),
        ),
      ),
    );
  }
}
