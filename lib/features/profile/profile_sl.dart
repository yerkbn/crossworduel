import 'package:crossworduel/config/network/custom_dio.dart';
import 'package:crossworduel/core/service-locator/service_locator.dart';
import 'package:crossworduel/features/profile/data/datasources/history_local_datasource.dart';
import 'package:crossworduel/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:crossworduel/features/profile/data/repositories/history_repository_impl.dart';
import 'package:crossworduel/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:crossworduel/features/profile/domain/repositories/history_repository_contract.dart';
import 'package:crossworduel/features/profile/domain/repositories/profile_repository_contract.dart';
import 'package:crossworduel/features/profile/domain/usecases/add_history_usecase.dart';
import 'package:crossworduel/features/profile/domain/usecases/check_username_usecase.dart';
import 'package:crossworduel/features/profile/domain/usecases/delete_user_usecase.dart';
import 'package:crossworduel/features/profile/domain/usecases/get_heart_time_usecase.dart';
import 'package:crossworduel/features/profile/domain/usecases/get_history_usecase.dart';
import 'package:crossworduel/features/profile/domain/usecases/get_notification_usecase.dart';
import 'package:crossworduel/features/profile/domain/usecases/profile_edit_usecase.dart';
import 'package:crossworduel/features/profile/domain/usecases/refresh_me_usecase.dart';
import 'package:crossworduel/features/profile/presentation/bloc/profile_settings/profile_settings_bloc.dart';
import 'package:crossworduel/features/profile/presentation/bloc/username_checker_bloc/username_checker_bloc.dart';
import 'package:get_it/get_it.dart';

class ProfileServiceLocator extends ServiceLocator {
  /// Factory will generate new instance every time when requested
  /// Singleton will generate only one instance and will give it to every caller
  /// Lazy will generate instance when it is called for the first time
  @override
  Future<void> call(GetIt sl) async {
    sl.registerFactory(() => ProfileSettingsBloc(
        updateProfileSettingsUsecase: sl(), deleteUserUsecase: sl()));

    sl.registerFactory(() => UsernameCheckerBloc(checkUsernameUsecase: sl()));

    // use cases
    sl.registerLazySingleton(() => GetHeartTimeUsecase(sl()));
    sl.registerLazySingleton(() => RefreshMeUsecase(sl()));
    sl.registerLazySingleton(() => ProfileEditUsecase(sl()));
    sl.registerLazySingleton(() => GetNotificationUsecase(sl()));
    sl.registerLazySingleton(() => CheckUsernameUsecase(repository: sl()));
    sl.registerLazySingleton(() => DeleteUserUsecase(repository: sl()));
    sl.registerLazySingleton(() => GetHistoryUsecase(repository: sl()));
    sl.registerLazySingleton(() => AddHistoryUsecase(repository: sl()));
    // repositories
    sl.registerLazySingleton<ProfileRepositoryContract>(() =>
        ProfileRepositoryImpl(localDateSoursce: sl(), remoteDataSource: sl()));

    sl.registerLazySingleton<HistoryRepositoryContract>(
        () => HistoryRepositoryImpl(historyLocalDataSource: sl()));

    // data sources

    sl.registerLazySingleton<ProfileRemoteDataSourceContract>(
        () => ProfileRemoteDataSourceImpl(authDio: sl<CustomAuthDio>()));

    sl.registerLazySingleton<HistoryLocalDataSourceContract>(
        () => HistoryLocalDataSourceImpl(flutterSecureStorage: sl()));
  }
}
