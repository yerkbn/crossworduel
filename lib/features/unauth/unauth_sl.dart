import 'package:crossworduel/features/unauth/data/datasources/unauth_local_data_source.dart';
import 'package:crossworduel/features/unauth/data/datasources/unauth_remote_data_source.dart';
import 'package:crossworduel/features/unauth/data/repositories/unauth_repository_impl.dart';
import 'package:crossworduel/features/unauth/domain/repositories/unauth_repository_contract.dart';
import 'package:crossworduel/features/unauth/domain/usecases/apple_signin_usecase.dart';
import 'package:crossworduel/features/unauth/domain/usecases/get_me_usecase.dart';
import 'package:crossworduel/features/unauth/domain/usecases/google_signin_usecase.dart';
import 'package:crossworduel/features/unauth/domain/usecases/logout_usecase.dart';
import 'package:crossworduel/features/unauth/domain/usecases/signin_usecase.dart';
import 'package:crossworduel/features/unauth/presentation/bloc/auth/auth_bloc.dart';
import 'package:crossworduel/features/unauth/presentation/bloc/signin/signin_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:crossworduel/config/network/custom_dio.dart';
import 'package:crossworduel/core/local-pub/custom_storage/custom_storage.dart';
import 'package:crossworduel/core/service-locator/service_locator.dart';

class UnauthServiceLocator extends ServiceLocator {
  /// Factory will generate new instance every time when requested
  /// Singleton will generate only one instance and will give it to every caller
  /// Lazy will generate instance when it is called for the first time
  @override
  Future<void> call(GetIt sl) async {
    sl.registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        getMe: sl(),
        logout: sl(),
        refreshMe: sl(),
      ),
    );
    sl.registerFactory<SigninBloc>(() => SigninBloc(
        authBloc: sl(), googleSignin: sl(), appleSigninUsecase: sl()));

    // use cases
    sl.registerLazySingleton(() => SigninUsecase(sl()));
    sl.registerLazySingleton(() => GoogleSigninUsecase(sl()));
    sl.registerLazySingleton(() => AppleSigninUsecase(sl()));
    sl.registerLazySingleton(() => GetMeUsecase(sl()));
    sl.registerLazySingleton(() => LogoutUsecase(sl()));
    // repositories
    sl.registerLazySingleton<UnauthRepositoryContract>(
        () => UnauthRepositoryImpl(
              localDateSoursce: sl(),
              remoteDataSource: sl(),
            ));

    // data sources
    sl.registerLazySingleton<UnauthLocalDataSourceContract>(() =>
        UnauthLocalDataSourceImpl(
            storage: sl<CustomStorageContract>(), customAuthDio: sl()));

    sl.registerLazySingleton<UnauthRemoteDataSourceContract>(
        () => UnauthRemoteDataSourceImpl(unauthDio: sl<CustomUnauthDio>()));
  }
}
