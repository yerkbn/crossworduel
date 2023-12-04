import 'package:dartz/dartz.dart';
import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:crossworduel/core/usecases/no_params.dart';
import 'package:crossworduel/core/usecases/usecase.dart';
import 'package:crossworduel/features/profile/domain/entities/notification_entity.dart';
import 'package:crossworduel/features/profile/domain/repositories/profile_repository_contract.dart';

class GetNotificationUsecase
    implements UseCase<List<NotificationEntity>, NoParams> {
  final ProfileRepositoryContract _repositoryContract;

  GetNotificationUsecase(this._repositoryContract);

  @override
  Future<Either<ExceptionData, List<NotificationEntity>>> call(
      NoParams params) async {
    return _repositoryContract.getNotification();
  }
}
