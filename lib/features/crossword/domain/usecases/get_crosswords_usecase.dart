import 'package:crossworduel/features/crossword/domain/entities/crossword_entity.dart';
import 'package:crossworduel/features/crossword/domain/entities/crosswords_filter_entity.dart';
import 'package:crossworduel/features/crossword/domain/repositories/crossword_repository_contract.dart';
import 'package:dartz/dartz.dart';
import 'package:crossworduel/core/exception/instruction_exception.dart';
import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:crossworduel/core/usecases/params_parent.dart';
import 'package:crossworduel/core/usecases/usecase.dart';

class GetCrosswordsUsecase
    implements UseCase<List<CrosswordEntity>, GetCrosswordsParams> {
  final CrosswordRepositoryContract _repositoryContract;

  GetCrosswordsUsecase(this._repositoryContract);

  @override
  Future<Either<ExceptionData, List<CrosswordEntity>>> call(
      GetCrosswordsParams params) async {
    try {
      return await _repositoryContract.getCrosswords(params);
    } catch (err) {
      return Left(ConfigurationInsException.parseMap({"crosswords": err}));
    }
  }
}

enum CrosswordsTypeEnum { World, History, Profile }

class GetCrosswordsParams extends ParamsParent {
  final CrosswordsTypeEnum type;
  final CrosswordsFilterEntity filterEntity;
  final String? userId;

  GetCrosswordsParams({
    required this.type,
    required this.filterEntity,
    this.userId,
  });

  @override
  Map<String, dynamic> getBody({Map<String, dynamic> params = const {}}) {
    return {};
  }

  @override
  List<Object?> get props => [type];
}
