import 'package:dartz/dartz.dart';
import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:crossworduel/core/usecases/no_params.dart';
import 'package:crossworduel/core/usecases/usecase.dart';
import 'package:crossworduel/features/unauth/domain/entities/me_entity.dart';
import 'package:crossworduel/features/unauth/domain/repositories/unauth_repository_contract.dart';

class GetMeUsecase implements UseCase<MeEntity, NoParams> {
  final UnauthRepositoryContract _getMeRepository;

  GetMeUsecase(this._getMeRepository);

  @override
  Future<Either<ExceptionData, MeEntity>> call(NoParams params) async {
    return _getMeRepository.getMe();
  }
}
