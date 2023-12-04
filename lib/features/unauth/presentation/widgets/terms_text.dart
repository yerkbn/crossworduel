import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crossworduel/config/network/network_config.dart';
import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsPrivacyText extends StatelessWidget {
  const TermsPrivacyText({super.key});

  Future<void> _onTermsTap() async {
    await launchUrl(Uri.parse(globalSL<NetworkConfig>().termsUrl));
  }

  Future<void> _onPrivacyTap() async {
    await launchUrl(Uri.parse(globalSL<NetworkConfig>().privacyUrl));
  }

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: "By pressing Sign in, you agree to our ",
            style: theme.headline3.copyWith(
              color: Colors.white70,
              fontSize: 14.sp,
            ),
          ),
          TextSpan(
              text: ' Privacy terms',
              style: theme.headline1.copyWith(
                color: Colors.white,
                fontSize: 16.h,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _onPrivacyTap();
                }),
        ],
      ),
    );
  }
}
