import 'dart:convert';
import 'package:crossworduel/config/network/custom_dio.dart';
import 'package:crossworduel/core/exception/cache_exception.dart';
import 'package:crossworduel/core/local-pub/custom_storage/custom_storage.dart';
import 'package:crossworduel/features/unauth/domain/entities/me_entity.dart';

abstract class UnauthLocalDataSourceContract {
  static const String storageKey = 'meModelStorageKey';
  Future<MeEntity> getMe();
  Future<void> cacheMe(MeEntity meToCache);
  Future<void> clear();
}

class UnauthLocalDataSourceImpl implements UnauthLocalDataSourceContract {
  final CustomStorageContract storage;
  final CustomAuthDio customAuthDio;
  UnauthLocalDataSourceImpl(
      {required this.storage, required this.customAuthDio});

  @override
  Future<MeEntity> getMe() async {
    final String? jsonString =
        await storage.read(key: UnauthLocalDataSourceContract.storageKey);
    if (jsonString != null) {
      final MeEntity meModel =
          MeEntity.fromJson(json.decode(jsonString) as Map<String, dynamic>);
      return Future.value(meModel);
    } else {
      throw CacheExcD();
    }
  }

  @override
  Future<void> cacheMe(MeEntity meToCache) {
    return storage.write(
      key: UnauthLocalDataSourceContract.storageKey,
      value: json.encode(meToCache.toJson()),
    );
  }

  @override
  Future<void> clear() {
    return storage.delete(
      key: UnauthLocalDataSourceContract.storageKey,
    );
  }
}
