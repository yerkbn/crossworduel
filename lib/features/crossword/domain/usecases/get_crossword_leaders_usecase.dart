import 'package:crossworduel/features/crossword/domain/entities/crossword_finish_entity.dart';
import 'package:crossworduel/features/crossword/domain/repositories/crossword_repository_contract.dart';
import 'package:dartz/dartz.dart';
import 'package:crossworduel/core/exception/instruction_exception.dart';
import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:crossworduel/core/usecases/params_parent.dart';
import 'package:crossworduel/core/usecases/usecase.dart';

class GetCrosswordLeadersUsecase
    implements UseCase<List<CrosswordFinishEntity>, GetCrosswordLeadersParams> {
  final CrosswordRepositoryContract _repositoryContract;

  GetCrosswordLeadersUsecase(this._repositoryContract);

  @override
  Future<Either<ExceptionData, List<CrosswordFinishEntity>>> call(
      GetCrosswordLeadersParams params) async {
    try {
      return await _repositoryContract.getCrosswordLeaders(params);
    } catch (err) {
      return Left(ConfigurationInsException.parseMap({"leaderboard": err}));
    }
  }
}

class GetCrosswordLeadersParams extends ParamsParent {
  final String crosswordId;

  GetCrosswordLeadersParams({required this.crosswordId});

  @override
  Map<String, dynamic> getBody({Map<String, dynamic> params = const {}}) {
    return {};
  }

  @override
  List<Object?> get props => [crosswordId];
}
