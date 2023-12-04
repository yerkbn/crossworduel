import 'package:dartz/dartz.dart';
import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:crossworduel/core/usecases/no_params.dart';
import 'package:crossworduel/core/usecases/usecase.dart';
import 'package:crossworduel/features/profile/domain/entities/heart_time_entity.dart';
import 'package:crossworduel/features/profile/domain/repositories/profile_repository_contract.dart';

class GetHeartTimeUsecase implements UseCase<HeartTimeEntity, NoParams> {
  final ProfileRepositoryContract _repositoryContract;

  GetHeartTimeUsecase(this._repositoryContract);

  @override
  Future<Either<ExceptionData, HeartTimeEntity>> call(NoParams params) async {
    return _repositoryContract.getHeartTime();
  }
}
