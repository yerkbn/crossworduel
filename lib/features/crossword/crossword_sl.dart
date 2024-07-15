import 'package:crossworduel/core/service-locator/service_locator.dart';
import 'package:crossworduel/features/crossword/domain/repositories/crossword_repository_contract.dart';
import 'package:crossworduel/features/crossword/domain/usecases/finish_crossword_usecase.dart';
import 'package:crossworduel/features/crossword/domain/usecases/get_crossword_leaders_usecase.dart';
import 'package:crossworduel/features/crossword/domain/usecases/get_crossword_usecase.dart';
import 'package:crossworduel/features/crossword/domain/usecases/get_crosswords_usecase.dart';
import 'package:crossworduel/features/crossword/domain/usecases/set_rating_usecase.dart';
import 'package:crossworduel/features/crossword/presentation/bloc/category/category_bloc.dart';
import 'package:crossworduel/features/crossword/presentation/bloc/crossword_run/crossword_run_cubit.dart';
import 'package:crossworduel/features/crossword/presentation/bloc/crosswords_filter/crosswords_filter_cubit.dart';
import 'package:crossworduel/features/crossword/presentation/bloc/timer/timer_cubit.dart';
import 'package:get_it/get_it.dart';

class CrosswordServiceLocator extends ServiceLocator {
  /// Factory will generate new instance every time when requested
  /// Singleton will generate only one instance and will give it to every caller
  /// Lazy will generate instance when it is called for the first time
  @override
  Future<void> call(GetIt sl) async {
    // block
    sl.registerLazySingleton<CategoryBloc>(() => CategoryBloc());
    sl.registerLazySingleton<CrosswordRunCubit>(() => CrosswordRunCubit());
    sl.registerFactory<TimerCubit>(() => TimerCubit());
    sl.registerLazySingleton<CrosswordsFilterCubit>(
        () => CrosswordsFilterCubit());
    // use cases
    sl.registerLazySingleton(() => GetCrosswordsUsecase(sl()));
    sl.registerLazySingleton(() => GetCrosswordUsecase(sl()));
    sl.registerLazySingleton(() => SetRatingUsecase(sl()));
    sl.registerLazySingleton(() => FinishCrosswordUsecase(sl()));
    sl.registerLazySingleton(() => GetCrosswordLeadersUsecase(sl()));
    // repositories
    sl.registerLazySingleton<CrosswordRepositoryContract>(
        () => CrosswordRepositoryImpl(supabaseClient: sl()));
  }
}
