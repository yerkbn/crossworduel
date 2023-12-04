import 'package:dartz/dartz.dart';
import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:crossworduel/core/usecases/no_params.dart';
import 'package:crossworduel/core/usecases/usecase.dart';
import 'package:crossworduel/features/profile/domain/repositories/profile_repository_contract.dart';

class DeleteUserUsecase extends UseCase<void, NoParams> {
  DeleteUserUsecase({required this.repository});
  final ProfileRepositoryContract repository;
  @override
  Future<Either<ExceptionData, void>> call(NoParams params) async {
    return repository.deleteUser();
  }
}
