import 'package:crossworduel/core/service-locator/service_locator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

abstract class CustomStorageContract extends ServiceLocator {
  Future<String?> read({required String key});
  Future<void> write({required String key, required String value});
  Future<void> delete({required String key});
}

class SecureCustomStorage extends CustomStorageContract {
  final FlutterSecureStorage flutterSecureStorage;

  SecureCustomStorage(
      {this.flutterSecureStorage = const FlutterSecureStorage()});

  @override
  Future<void> delete({required String key}) async {
    await flutterSecureStorage.delete(key: key);
  }

  @override
  Future<String?> read({required String key}) async {
    return flutterSecureStorage.read(key: key);
  }

  @override
  Future<void> write({required String key, required String value}) async {
    await flutterSecureStorage.write(key: key, value: value);
  }

  @override
  Future<void> call(GetIt sl) async {
    sl.registerLazySingleton<CustomStorageContract>(() => this);
  }
}
