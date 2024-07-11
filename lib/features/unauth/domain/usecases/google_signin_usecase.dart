import 'package:dartz/dartz.dart';
import 'package:crossworduel/core/exception/instruction_exception.dart';
import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:crossworduel/core/usecases/no_params.dart';
import 'package:crossworduel/core/usecases/usecase.dart';
import 'package:crossworduel/features/unauth/domain/entities/me_entity.dart';
import 'package:crossworduel/features/unauth/domain/repositories/unauth_repository_contract.dart';

class GoogleSigninUsecase implements UseCase<MeEntity, NoParams> {
  final UnauthRepositoryContract _repositoryContract;

  GoogleSigninUsecase(this._repositoryContract);

  @override
  Future<Either<ExceptionData, MeEntity>> call(NoParams params) async {
    try {
      await _repositoryContract.clear();
      return _repositoryContract.signinWithGoogle();
    } catch (err) {
      return Left(ConfigurationInsException.parseMap({"google signin": err}));
    }
  }
}
