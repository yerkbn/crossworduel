import 'package:dartz/dartz.dart';
import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:crossworduel/core/usecases/no_params.dart';
import 'package:crossworduel/features/profile/domain/entities/heart_time_entity.dart';
import 'package:crossworduel/features/profile/domain/entities/notification_entity.dart';
import 'package:crossworduel/features/profile/domain/entities/score_entity.dart';
import 'package:crossworduel/features/profile/domain/usecases/check_username_usecase.dart';
import 'package:crossworduel/features/profile/domain/usecases/profile_edit_usecase.dart';
import 'package:crossworduel/features/unauth/domain/entities/me_entity.dart';

abstract class ProfileRepositoryContract {
  /// edit profile
  Future<Either<ExceptionData, MeEntity>> edit(ProfileEditParams params);

  Future<Either<ExceptionData, ScoreEntity>> myScore(NoParams params);

  Future<Either<ExceptionData, MeEntity>> refreshMe();

  Future<Either<ExceptionData, List<NotificationEntity>>> getNotification();

  Future<Either<ExceptionData, void>> checkUsername(UsernameParams params);

  Future<Either<ExceptionData, void>> deleteUser();

  Future<Either<ExceptionData, HeartTimeEntity>> getHeartTime();
}
