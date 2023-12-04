import 'package:dartz/dartz.dart';
import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:crossworduel/core/usecases/params_parent.dart';
import 'package:crossworduel/core/usecases/usecase.dart';
import 'package:crossworduel/features/profile/domain/repositories/profile_repository_contract.dart';

class CheckUsernameUsecase extends UseCase<void, UsernameParams> {
  final ProfileRepositoryContract repository;

  CheckUsernameUsecase({required this.repository});
  @override
  Future<Either<ExceptionData, void>> call(UsernameParams params) {
    return repository.checkUsername(params);
  }
}

class UsernameParams extends ParamsParent {
  final String username;

  const UsernameParams(this.username);

  @override
  Map<String, dynamic> getBody({Map<String, dynamic> params = const {}}) {
    return {
      "username": username,
    };
  }

  @override
  List<Object?> get props => [username];
}
