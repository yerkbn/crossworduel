import 'package:crossworduel/features/crossword/domain/entities/crossword_entity.dart';
import 'package:crossworduel/features/crossword/domain/repositories/crossword_repository_contract.dart';
import 'package:dartz/dartz.dart';
import 'package:crossworduel/core/exception/instruction_exception.dart';
import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:crossworduel/core/usecases/params_parent.dart';
import 'package:crossworduel/core/usecases/usecase.dart';

class SetRatingUsecase implements UseCase<CrosswordEntity, SetRatingParams> {
  final CrosswordRepositoryContract _repositoryContract;

  SetRatingUsecase(this._repositoryContract);

  @override
  Future<Either<ExceptionData, CrosswordEntity>> call(
      SetRatingParams params) async {
    try {
      return await _repositoryContract.setRating(params);
    } catch (err) {
      return Left(ConfigurationInsException.parseMap({"set rating": err}));
    }
  }
}

enum CrosswordsTypEnum { My, World, History, Profile }

class SetRatingParams extends ParamsParent {
  final int star;
  final String crosswordId;

  SetRatingParams({required this.star, required this.crosswordId});

  @override
  Map<String, dynamic> getBody({Map<String, dynamic> params = const {}}) {
    return {};
  }

  @override
  List<Object?> get props => [crosswordId, star];
}
