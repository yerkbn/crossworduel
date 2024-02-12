import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:crossworduel/core/usecases/params_parent.dart';
import 'package:crossworduel/core/usecases/usecase.dart';
import 'package:crossworduel/features/profile/domain/entities/history_entity.dart';
import 'package:crossworduel/features/profile/domain/repositories/history_repository_contract.dart';
import 'package:dartz/dartz.dart';

class AddHistoryUsecase extends UseCase<void, HistoryParams> {
  final HistoryRepositoryContract repository;

  AddHistoryUsecase({required this.repository});
  @override
  Future<Either<ExceptionData, void>> call(HistoryParams params) {
    return repository.cacheHistory(params);
  }
}

class HistoryParams extends ParamsParent {
  final HistoryEntity history;

  const HistoryParams(this.history);

  @override
  Map<String, dynamic> getBody({Map<String, dynamic> params = const {}}) {
    return {};
  }

  @override
  List<Object?> get props => [history];
}
