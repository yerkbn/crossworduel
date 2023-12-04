// import 'package:crossworduel/config/ui/custom_theme_extension.dart';
// import 'package:crossworduel/config/ui/ui_config.dart';
// import 'package:crossworduel/game/presentation/ui/page/game_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//         designSize: const Size(UiConfig.globalWidth, UiConfig.globalHeight),
//         builder: (_, __) {
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             theme: CustomThemeExtension.lightThemeData,
//             darkTheme: CustomThemeExtension.lightThemeData,
//             home: const GamePage(),
//           );
//         });
//   }
// }

import 'package:crossworduel/config/app/app_sl.dart';
import 'package:crossworduel/config/app/app_wrapper.dart';
import 'package:crossworduel/config/network/network_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  final NetworkConfig networkConfig = NetworkConfig(
    globalBackendUrl: "https://sappass.dev:7000",
    globalBattleSocket: "wss://sappass.dev:7001",
    termsUrl: "",
    privacyUrl: "",
    iosAppId: "1487535179",
    androidAppId: "com.game.azionline",
  );

  final AppSl appSl = AppSl(
    networkConfig: networkConfig,
  );

  final AppWrapper appWrapper = AppWrapper(
    appSl: appSl,
  );

  await appWrapper.init();

  runApp(appWrapper);
}
