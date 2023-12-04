import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crossworduel/config/ui/custom_theme_extension.dart';

class OnboardingItemPage extends StatelessWidget {
  final String header;
  final String description;
  final String image;
  final double widthImage;
  final double heightImage;
  const OnboardingItemPage({
    super.key,
    required this.header,
    required this.image,
    required this.description,
    this.widthImage = 365,
    this.heightImage = 365,
  });

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
            child:
                Image.asset(image, width: widthImage.w, height: heightImage.h)),
        Padding(
          padding: EdgeInsets.all(10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(header, style: theme.headline1.copyWith(fontSize: 26.h)),
              SizedBox(height: 10.h),
              Text(
                description,
                style: theme.headline4.copyWith(
                  color: Colors.white.withOpacity(0.88),
                  fontSize: 16.h,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
