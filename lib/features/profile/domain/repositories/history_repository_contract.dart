import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:crossworduel/core/usecases/no_params.dart';
import 'package:crossworduel/features/profile/domain/entities/history_entity.dart';
import 'package:crossworduel/features/profile/domain/usecases/add_history_usecase.dart';
import 'package:dartz/dartz.dart';

abstract class HistoryRepositoryContract {
  Future<Either<ExceptionData, List<HistoryEntity>>> getHistories(
      NoParams params);

  Future<Either<ExceptionData, void>> cacheHistory(HistoryParams params);
}
