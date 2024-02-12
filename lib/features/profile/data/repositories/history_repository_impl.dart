import 'package:crossworduel/core/exception/exception2either.dart';
import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:crossworduel/core/usecases/no_params.dart';
import 'package:crossworduel/features/profile/data/datasources/history_local_datasource.dart';
import 'package:crossworduel/features/profile/data/models/history_model.dart';
import 'package:crossworduel/features/profile/domain/entities/history_entity.dart';
import 'package:crossworduel/features/profile/domain/repositories/history_repository_contract.dart';
import 'package:crossworduel/features/profile/domain/usecases/add_history_usecase.dart';
import 'package:dartz/dartz.dart';

class HistoryRepositoryImpl implements HistoryRepositoryContract {
  final HistoryLocalDataSourceContract historyLocalDataSource;

  HistoryRepositoryImpl({required this.historyLocalDataSource});

  @override
  Future<Either<ExceptionData, void>> cacheHistory(HistoryParams params) async {
    return exception2either(function: () async {
      await historyLocalDataSource
          .cacheHistory(HistoryModel.fromEntity(params.history));
    });
  }

  @override
  Future<Either<ExceptionData, List<HistoryEntity>>> getHistories(
      NoParams params) {
    return exception2either(function: () async {
      return await historyLocalDataSource.getHistories();
    });
  }
}
