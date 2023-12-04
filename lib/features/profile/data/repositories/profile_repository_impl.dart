import 'package:dartz/dartz.dart';
import 'package:crossworduel/core/exception/exception2either.dart';
import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:crossworduel/core/usecases/no_params.dart';
import 'package:crossworduel/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:crossworduel/features/profile/domain/entities/heart_time_entity.dart';
import 'package:crossworduel/features/profile/domain/entities/notification_entity.dart';
import 'package:crossworduel/features/profile/domain/entities/score_entity.dart';
import 'package:crossworduel/features/profile/domain/repositories/profile_repository_contract.dart';
import 'package:crossworduel/features/profile/domain/usecases/check_username_usecase.dart';
import 'package:crossworduel/features/profile/domain/usecases/profile_edit_usecase.dart';
import 'package:crossworduel/features/unauth/data/datasources/unauth_local_data_source.dart';
import 'package:crossworduel/features/unauth/data/models/me_model.dart';
import 'package:crossworduel/features/unauth/domain/entities/me_entity.dart';

class ProfileRepositoryImpl implements ProfileRepositoryContract {
  final UnauthLocalDataSourceContract localDateSoursce;
  final ProfileRemoteDataSourceContract remoteDataSource;

  ProfileRepositoryImpl(
      {required this.localDateSoursce, required this.remoteDataSource});

  @override
  Future<Either<ExceptionData, MeEntity>> edit(ProfileEditParams params) async {
    return exception2either(function: () async {
      final MeModel meModel = await remoteDataSource.edit(params.getBody());
      await localDateSoursce.cacheMe(meModel);
      return meModel;
    });
  }

  @override
  Future<Either<ExceptionData, ScoreEntity>> myScore(NoParams params) {
    return exception2either(function: () async {
      return await remoteDataSource.myScore();
    });
  }

  @override
  Future<Either<ExceptionData, MeEntity>> refreshMe() {
    return exception2either(function: () async {
      MeModel me = await remoteDataSource.refreshMe();
      await localDateSoursce.cacheMe(me);
      return me;
    });
  }

  @override
  Future<Either<ExceptionData, List<NotificationEntity>>> getNotification() {
    return exception2either(function: () async {
      return await remoteDataSource.getNotification();
    });
  }

  @override
  Future<Either<ExceptionData, void>> checkUsername(UsernameParams params) {
    return exception2either<void>(function: () async {
      return remoteDataSource.checkUsername(params.getBody());
    });
  }

  @override
  Future<Either<ExceptionData, void>> deleteUser() {
    return exception2either<void>(function: () async {
      return remoteDataSource.deleteUser();
    });
  }

  @override
  Future<Either<ExceptionData, HeartTimeEntity>> getHeartTime() {
    return exception2either(function: () async {
      return await remoteDataSource.getHeartTime();
    });
  }
}
