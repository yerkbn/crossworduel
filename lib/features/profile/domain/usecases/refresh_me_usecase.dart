import 'package:dartz/dartz.dart';
import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:crossworduel/core/usecases/no_params.dart';
import 'package:crossworduel/core/usecases/usecase.dart';
import 'package:crossworduel/features/profile/domain/repositories/profile_repository_contract.dart';
import 'package:crossworduel/features/unauth/domain/entities/me_entity.dart';

class RefreshMeUsecase implements UseCase<MeEntity, NoParams> {
  final ProfileRepositoryContract _repositoryContract;

  RefreshMeUsecase(this._repositoryContract);

  @override
  Future<Either<ExceptionData, MeEntity>> call(NoParams params) async {
    return _repositoryContract.refreshMe();
  }
}
