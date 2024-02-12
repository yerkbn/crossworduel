import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:crossworduel/core/usecases/no_params.dart';
import 'package:crossworduel/core/usecases/usecase.dart';
import 'package:crossworduel/features/profile/domain/entities/history_entity.dart';
import 'package:crossworduel/features/profile/domain/repositories/history_repository_contract.dart';
import 'package:dartz/dartz.dart';

class GetHistoryUsecase extends UseCase<List<HistoryEntity>, NoParams> {
  final HistoryRepositoryContract repository;

  GetHistoryUsecase({required this.repository});
  @override
  Future<Either<ExceptionData, List<HistoryEntity>>> call(NoParams params) {
    return repository.getHistories(params);
  }
}
