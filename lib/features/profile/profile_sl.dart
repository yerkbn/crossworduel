import 'package:crossworduel/core/service-locator/service_locator.dart';
import 'package:crossworduel/features/profile/data/datasources/history_local_datasource.dart';
import 'package:crossworduel/features/profile/data/repositories/history_repository_impl.dart';
import 'package:crossworduel/features/profile/domain/repositories/history_repository_contract.dart';
import 'package:crossworduel/features/profile/domain/usecases/add_history_usecase.dart';
import 'package:get_it/get_it.dart';

class ProfileServiceLocator extends ServiceLocator {
  /// Factory will generate new instance every time when requested
  /// Singleton will generate only one instance and will give it to every caller
  /// Lazy will generate instance when it is called for the first time
  @override
  Future<void> call(GetIt sl) async {
    // use cases

    sl.registerLazySingleton(() => AddHistoryUsecase(repository: sl()));
    // repositories

    sl.registerLazySingleton<HistoryRepositoryContract>(
        () => HistoryRepositoryImpl(historyLocalDataSource: sl()));

    // data sources

    sl.registerLazySingleton<HistoryLocalDataSourceContract>(
        () => HistoryLocalDataSourceImpl(flutterSecureStorage: sl()));
  }
}
