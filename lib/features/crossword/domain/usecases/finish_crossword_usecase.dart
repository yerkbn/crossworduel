import 'package:crossworduel/features/crossword/domain/repositories/crossword_repository_contract.dart';
import 'package:dartz/dartz.dart';
import 'package:crossworduel/core/exception/instruction_exception.dart';
import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:crossworduel/core/usecases/params_parent.dart';
import 'package:crossworduel/core/usecases/usecase.dart';

class FinishCrosswordUsecase implements UseCase<None, FinishCrosswordParams> {
  final CrosswordRepositoryContract _repositoryContract;

  FinishCrosswordUsecase(this._repositoryContract);

  @override
  Future<Either<ExceptionData, None>> call(FinishCrosswordParams params) async {
    try {
      return await _repositoryContract.finishCrossword(params);
    } catch (err) {
      return Left(ConfigurationInsException.parseMap({"set rating": err}));
    }
  }
}

class FinishCrosswordParams extends ParamsParent {
  final int secondsElapsed;
  final String crosswordId;

  FinishCrosswordParams({
    required this.secondsElapsed,
    required this.crosswordId,
  });

  @override
  Map<String, dynamic> getBody({Map<String, dynamic> params = const {}}) {
    return {"seconds_elapsed": secondsElapsed, "id": crosswordId};
  }

  @override
  List<Object?> get props => [crosswordId, secondsElapsed];
}
