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
