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
            text:
                "By signing in, you confirm that you have read and agree to our Privacy Policy  ",
            style: theme.headline3.copyWith(
              color: theme.backgroundColor4,
              fontSize: 12.sp,
            ),
          ),
          TextSpan(
              text: 'Privacy terms',
              style: theme.headline1.copyWith(
                color: theme.backgroundColor1,
                fontSize: 14.h,
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
