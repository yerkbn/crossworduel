import 'package:crossworduel/config/network/network_config.dart';
import 'package:crossworduel/core/service-locator/service_locator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

class AppSl extends ServiceLocator {
  final NetworkConfig networkConfig;
  AppSl({
    required this.networkConfig,
  });

  @override
  Future<void> call(GetIt sl) async {
    sl.registerLazySingleton(() => networkConfig);
    sl.registerLazySingleton(() => const FlutterSecureStorage());
  }
}
