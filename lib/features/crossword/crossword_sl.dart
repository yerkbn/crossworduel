import 'package:crossworduel/core/service-locator/service_locator.dart';
import 'package:crossworduel/features/crossword/domain/repositories/crossword_repository_contract.dart';
import 'package:crossworduel/features/crossword/domain/usecases/get_crosswords_usecase.dart';
import 'package:crossworduel/features/crossword/presentation/bloc/category/category_bloc.dart';
import 'package:get_it/get_it.dart';

class CrosswordServiceLocator extends ServiceLocator {
  /// Factory will generate new instance every time when requested
  /// Singleton will generate only one instance and will give it to every caller
  /// Lazy will generate instance when it is called for the first time
  @override
  Future<void> call(GetIt sl) async {
    // block
    sl.registerLazySingleton<CategoryBloc>(() => CategoryBloc());
    // use cases
    sl.registerLazySingleton(() => GetCrosswordUsecase(sl()));
    // repositories
    sl.registerLazySingleton<CrosswordRepositoryContract>(
        () => CrosswordRepositoryImpl(supabaseClient: sl()));
  }
}
