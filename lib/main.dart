import 'package:crossworduel/config/app/app_sl.dart';
import 'package:crossworduel/config/app/app_wrapper.dart';
import 'package:crossworduel/config/network/network_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://tsidyavuythkstcgutjt.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRzaWR5YXZ1eXRoa3N0Y2d1dGp0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjA0MTY4MzQsImV4cCI6MjAzNTk5MjgzNH0.66VpkzNaIMr5nafQ5p_g5VRyuDxhganPLizNJ9uKPcM",
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  final NetworkConfig networkConfig = NetworkConfig(
    globalBackendUrl: "https://sappass.dev:7000",
    globalBattleSocket: "wss://sappass.dev:7001",
    termsUrl: "",
    privacyUrl: "",
    iosAppId: "1487535179",
    androidAppId: "",
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
