import 'package:dartz/dartz.dart';
import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:crossworduel/core/usecases/no_params.dart';
import 'package:crossworduel/core/usecases/usecase.dart';
import 'package:crossworduel/features/unauth/domain/repositories/unauth_repository_contract.dart';

class LogoutUsecase extends UseCase<void, NoParams> {
  final UnauthRepositoryContract _repository;

  LogoutUsecase(this._repository);

  @override
  Future<Either<ExceptionData, void>> call(NoParams params) async {
    return _repository.clear();
  }
}
