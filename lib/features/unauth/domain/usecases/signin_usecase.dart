import 'package:dartz/dartz.dart';
import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:crossworduel/core/usecases/params_parent.dart';
import 'package:crossworduel/core/usecases/usecase.dart';
import 'package:crossworduel/features/unauth/domain/entities/me_entity.dart';
import 'package:crossworduel/features/unauth/domain/repositories/unauth_repository_contract.dart';

class SigninUsecase implements UseCase<MeEntity, SigninParams> {
  final UnauthRepositoryContract _repositoryContract;

  SigninUsecase(this._repositoryContract);

  @override
  Future<Either<ExceptionData, MeEntity>> call(SigninParams params) async {
    return _repositoryContract.signin(params);
  }
}

class SigninParams extends ParamsParent {
  final String email;
  final String pushToken;

  const SigninParams({
    required this.email,
    required this.pushToken,
  });

  @override
  List<Object?> get props => [email];

  @override
  Map<String, dynamic> getBody({Map<String, dynamic> params = const {}}) => {
        "email": email,
        "pushToken": pushToken,
      };
}
