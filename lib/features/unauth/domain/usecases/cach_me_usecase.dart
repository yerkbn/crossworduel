import 'package:crossworduel/core/usecases/params_parent.dart';
import 'package:dartz/dartz.dart';
import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:crossworduel/core/usecases/usecase.dart';
import 'package:crossworduel/features/unauth/domain/entities/me_entity.dart';
import 'package:crossworduel/features/unauth/domain/repositories/unauth_repository_contract.dart';

class CacheMeUsecase implements UseCase<MeEntity, CacheMeParams> {
  final UnauthRepositoryContract _getMeRepository;

  CacheMeUsecase(this._getMeRepository);

  @override
  Future<Either<ExceptionData, MeEntity>> call(CacheMeParams params) async {
    return _getMeRepository.cacheMe(params);
  }
}

class CacheMeParams extends ParamsParent {
  final MeEntity me;

  const CacheMeParams({required this.me});

  @override
  List<Object?> get props => [me];

  @override
  Map<String, dynamic> getBody({Map<String, dynamic> params = const {}}) => {};
}
