import 'package:crossworduel/config/network/network_config.dart';
import 'package:crossworduel/core/service-locator/service_locator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppSl extends ServiceLocator {
  final NetworkConfig networkConfig;
  AppSl({
    required this.networkConfig,
  });

  @override
  Future<void> call(GetIt sl) async {
    sl.registerLazySingleton(() => networkConfig);
    sl.registerLazySingleton(() => const FlutterSecureStorage());
    sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
    sl.registerLazySingleton(() => GoogleSignIn(
          clientId:
              "125694937780-amu1nog0icc1b4tncg6epoke0t33bhhd.apps.googleusercontent.com",
          serverClientId:
              "125694937780-e151ka55ofdrkcq059h3m2eq4ujcaubp.apps.googleusercontent.com",
        ));
  }
}
