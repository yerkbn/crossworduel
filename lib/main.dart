import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/config/ui/ui_config.dart';
import 'package:crossworduel/game/presentation/ui/page/game_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(UiConfig.globalWidth, UiConfig.globalHeight),
        builder: (_, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: CustomThemeExtension.lightThemeData,
            darkTheme: CustomThemeExtension.lightThemeData,
            home: const GamePage(),
          );
        });
  }
}
