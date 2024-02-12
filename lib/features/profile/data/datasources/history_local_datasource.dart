import 'dart:convert';
import 'package:crossworduel/features/profile/data/models/history_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class HistoryLocalDataSourceContract {
  static const String storageKey = 'STORAGE_KEY_HISTORY_MODEL';

  Future<List<HistoryModel>> getHistories();
  Future<void> cacheHistory(HistoryModel historyToCache);
  Future<void> clear();
}

class HistoryLocalDataSourceImpl implements HistoryLocalDataSourceContract {
  final FlutterSecureStorage flutterSecureStorage;

  HistoryLocalDataSourceImpl({required this.flutterSecureStorage});

  @override
  Future<void> cacheHistory(HistoryModel historyToCache) async {
    final List<HistoryModel> histories = await getHistories();
    histories.insert(0, historyToCache);
    return flutterSecureStorage.write(
        key: HistoryLocalDataSourceContract.storageKey,
        value: json.encode(histories.map((e) => e.toJson()).toList()));
  }

  @override
  Future<List<HistoryModel>> getHistories() async {
    final String? jsonString = await flutterSecureStorage.read(
        key: HistoryLocalDataSourceContract.storageKey);
    if (jsonString != null) {
      final List<HistoryModel> histories =
          HistoryModel.fromJsonList(json.decode(jsonString) as List);
      return Future.value(histories);
    } else {
      return [];
    }
  }

  @override
  Future<void> clear() async {
    return flutterSecureStorage.delete(
      key: HistoryLocalDataSourceContract.storageKey,
    );
  }
}
