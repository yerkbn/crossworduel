import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  final Color primaryColor; // primary color of app and used to make accent
  final Color secondaryColor; // color to make secondary accent

  final Color backgroundColor1; // darkest background color
  final Color backgroundColor2;
  final Color backgroundColor3;
  final Color backgroundColor4; // lightest background color

  final Color textColor1; // most active text color
  final Color textColor2; // disabled color

  // Colors highlight
  final Color greenHardColor;
  final Color greenLightColor;

  final Color yellowHardColor;
  final Color yellowLightColor;

  final Color blueHardColor;
  final Color blueLightColor;

  final Color redHardColor;
  final Color redLightColor;

  CustomThemeExtension({
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor1,
    required this.backgroundColor2,
    required this.backgroundColor3,
    required this.backgroundColor4,
    required this.textColor1,
    required this.textColor2,
    required this.greenHardColor,
    required this.greenLightColor,
    required this.yellowHardColor,
    required this.yellowLightColor,
    required this.blueHardColor,
    required this.blueLightColor,
    required this.redHardColor,
    required this.redLightColor,
  });

  factory CustomThemeExtension.of(BuildContext context) {
    return Theme.of(context).extension<CustomThemeExtension>() ??
        CustomThemeExtension.dark();
  }

  factory CustomThemeExtension.light() => CustomThemeExtension(
        primaryColor: const Color(0xFF76AD8D),
        secondaryColor: const Color(0xFF219653),
        backgroundColor1: const Color(0xFF000000),
        backgroundColor2: const Color(0xFF161616),
        backgroundColor3: const Color(0xFF1F1F1F),
        backgroundColor4: const Color(0xFF29292D),
        textColor1: const Color(0xFFFFFFFF),
        textColor2: const Color(0xFF8E8E93),
        greenHardColor: const Color(0xFF219653),
        greenLightColor: const Color(0xFF76AD8D),
        yellowHardColor: const Color(0xFFDBD38D),
        yellowLightColor: const Color(0xFFFFFBD7),
        blueHardColor: const Color(0xFF1F93FD),
        blueLightColor: const Color(0xFFC1E1FF),
        redHardColor: const Color(0xFFD27C7C),
        redLightColor: const Color(0xFFFFAFAF),
      );

  factory CustomThemeExtension.dark() => CustomThemeExtension(
        primaryColor: const Color(0xFF76AD8D),
        secondaryColor: const Color(0xFF219653),
        backgroundColor1: const Color(0xFF000000),
        backgroundColor2: const Color(0xFF161616),
        backgroundColor3: const Color(0xFF1F1F1F),
        backgroundColor4: const Color(0xFF29292D),
        textColor1: const Color(0xFFFFFFFF),
        textColor2: const Color(0xFF8E8E93),
        greenHardColor: const Color(0xFF219653),
        greenLightColor: const Color(0xFF76AD8D),
        yellowHardColor: const Color(0xFFDBD38D),
        yellowLightColor: const Color(0xFFFFFBD7),
        blueHardColor: const Color(0xFF1F93FD),
        blueLightColor: const Color(0xFFC1E1FF),
        redHardColor: const Color(0xFFD27C7C),
        redLightColor: const Color(0xFFFFAFAF),
      );

  static ThemeData get darkThemeData =>
      getThemeData(extension: CustomThemeExtension.dark());

  static ThemeData get lightThemeData =>
      getThemeData(extension: CustomThemeExtension.light());

  static ThemeData getThemeData({required CustomThemeExtension extension}) {
    return ThemeData(
      inputDecorationTheme: const InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: Colors.black),
      ),
      appBarTheme: AppBarTheme(color: extension.backgroundColor2),
      scaffoldBackgroundColor: extension.backgroundColor1,
      primaryColor: extension.primaryColor,
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: Colors.black),
      extensions: [
        extension,
      ],
    );
  }

  TextStyle get headline1 => TextStyle(
        // 700
        color: textColor1,
        fontSize: 18.h,
        fontWeight: FontWeight.w700,
        fontFamily: "sf_heavy",
      );

  TextStyle get headline2 => TextStyle(
        // 700
        color: textColor1,
        fontSize: 16.h,
        fontWeight: FontWeight.w700,
        fontFamily: "sf_heavy",
      );

  TextStyle get headline3 => TextStyle(
        // 600
        color: textColor1,
        fontSize: 14.h,
        fontWeight: FontWeight.w600,
        fontFamily: "sf_bold",
      );

  TextStyle get headline4 => TextStyle(
        //500
        color: textColor2,
        fontSize: 14.h,
        fontWeight: FontWeight.w400,
        fontFamily: "sf_medium",
      );

  @override
  ThemeExtension<CustomThemeExtension> copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? backgroundColor1,
    Color? backgroundColor2,
    Color? backgroundColor3,
    Color? backgroundColor4,
    Color? textColor1,
    Color? textColor2,
    Color? greenHardColor,
    Color? greenLightColor,
    Color? yellowHardColor,
    Color? yellowLightColor,
    Color? redHardColor,
    Color? redLightColor,
    Color? blueHardColor,
    Color? blueLightColor,
  }) {
    return CustomThemeExtension(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      backgroundColor1: backgroundColor1 ?? this.backgroundColor1,
      backgroundColor2: backgroundColor2 ?? this.backgroundColor2,
      backgroundColor3: backgroundColor3 ?? this.backgroundColor3,
      backgroundColor4: backgroundColor4 ?? this.backgroundColor4,
      textColor1: textColor1 ?? this.textColor1,
      textColor2: textColor2 ?? this.textColor2,
      greenHardColor: greenHardColor ?? this.greenHardColor,
      greenLightColor: greenLightColor ?? this.greenLightColor,
      yellowHardColor: yellowHardColor ?? this.yellowHardColor,
      yellowLightColor: yellowLightColor ?? this.yellowLightColor,
      redHardColor: redHardColor ?? this.redHardColor,
      redLightColor: redLightColor ?? this.redLightColor,
      blueHardColor: blueHardColor ?? this.blueHardColor,
      blueLightColor: blueLightColor ?? this.blueLightColor,
    );
  }

  @override
  ThemeExtension<CustomThemeExtension> lerp(
    ThemeExtension<CustomThemeExtension>? other,
    double t,
  ) {
    if (other is! CustomThemeExtension) {
      return this;
    }
    return CustomThemeExtension(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
      backgroundColor1:
          Color.lerp(backgroundColor1, other.backgroundColor1, t)!,
      backgroundColor2:
          Color.lerp(backgroundColor2, other.backgroundColor2, t)!,
      backgroundColor3:
          Color.lerp(backgroundColor3, other.backgroundColor3, t)!,
      backgroundColor4:
          Color.lerp(backgroundColor4, other.backgroundColor4, t)!,
      textColor1: Color.lerp(textColor1, other.textColor1, t)!,
      textColor2: Color.lerp(textColor2, other.textColor2, t)!,
      greenHardColor: Color.lerp(greenHardColor, other.greenHardColor, t)!,
      greenLightColor: Color.lerp(greenLightColor, other.greenLightColor, t)!,
      yellowHardColor: Color.lerp(yellowHardColor, other.yellowHardColor, t)!,
      yellowLightColor:
          Color.lerp(yellowLightColor, other.yellowLightColor, t)!,
      redHardColor: Color.lerp(redHardColor, other.redHardColor, t)!,
      redLightColor: Color.lerp(redLightColor, other.redLightColor, t)!,
      blueHardColor: Color.lerp(blueHardColor, other.blueHardColor, t)!,
      blueLightColor: Color.lerp(blueLightColor, other.blueLightColor, t)!,
    );
  }
}
