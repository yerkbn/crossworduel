import 'package:crossworduel/features/crossword/domain/entities/crossword_entity.dart';
import 'package:crossworduel/features/crossword/domain/repositories/crossword_repository_contract.dart';
import 'package:dartz/dartz.dart';
import 'package:crossworduel/core/exception/instruction_exception.dart';
import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:crossworduel/core/usecases/params_parent.dart';
import 'package:crossworduel/core/usecases/usecase.dart';

class GetCrosswordUsecase
    implements UseCase<CrosswordEntity, GetCrosswordParams> {
  final CrosswordRepositoryContract _repositoryContract;

  GetCrosswordUsecase(this._repositoryContract);

  @override
  Future<Either<ExceptionData, CrosswordEntity>> call(
      GetCrosswordParams params) async {
    try {
      return await _repositoryContract.getCrossword(params);
    } catch (err) {
      return Left(ConfigurationInsException.parseMap({"crosswords": err}));
    }
  }
}

class GetCrosswordParams extends ParamsParent {
  final String crosswordId;

  GetCrosswordParams({required this.crosswordId});

  @override
  Map<String, dynamic> getBody({Map<String, dynamic> params = const {}}) {
    return {};
  }

  @override
  List<Object?> get props => [crosswordId];
}
