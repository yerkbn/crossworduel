import 'package:crossworduel/features/profile/data/models/score_model.dart';
import 'package:dartz/dartz.dart';
import 'package:crossworduel/core/exception/exception2either.dart';
import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:crossworduel/features/unauth/data/datasources/unauth_local_data_source.dart';
import 'package:crossworduel/features/unauth/data/datasources/unauth_remote_data_source.dart';
import 'package:crossworduel/features/unauth/data/models/me_model.dart';
import 'package:crossworduel/features/unauth/domain/entities/me_entity.dart';
import 'package:crossworduel/features/unauth/domain/repositories/unauth_repository_contract.dart';
import 'package:crossworduel/features/unauth/domain/usecases/apple_signin_usecase.dart';
import 'package:crossworduel/features/unauth/domain/usecases/signin_usecase.dart';
import 'package:crossworduel/features/unauth/domain/usecases/google_signin_usecase.dart';

class UnauthRepositoryImpl implements UnauthRepositoryContract {
  final UnauthLocalDataSourceContract localDateSoursce;
  final UnauthRemoteDataSourceContract remoteDataSource;

  UnauthRepositoryImpl({
    required this.localDateSoursce,
    required this.remoteDataSource,
  });

  @override
  Future<Either<ExceptionData, MeEntity>> getMe() async =>
      exception2either<MeEntity>(function: () async {
        return localDateSoursce.getMe();
      });

  @override
  Future<Either<ExceptionData, MeEntity>> signin(
      SigninParams signinParams) async {
    return exception2either(function: () async {
      final MeModel meModel =
          await remoteDataSource.signin(signinParams.getBody());

      await localDateSoursce.cacheMe(meModel);
      return meModel;
    });
  }

  @override
  Future<Either<ExceptionData, MeEntity>> signinWithGoogle(
      GoogleSigninParams params) async {
    return exception2either(function: () async {
      // ! uncomment me
      // final MeModel meModel =
      //     await remoteDataSource.signinWithGoogle(params.getBody());

      // ! Delete me
      const MeModel meModel = MeModel(
          id: "1",
          token: "ssss",
          username: "yerkbn",
          email: "yerkbn@gmail.com",
          avatar:
              "https://cdn.punchng.com/wp-content/uploads/2023/11/17224117/Sam-Altman.jpg",
          score: ScoreModel(point: 1000, heart: 5, strike: 12));

      await localDateSoursce.cacheMe(meModel);
      return meModel;
    });
  }

  @override
  Future<Either<ExceptionData, MeEntity>> signinWithApple(
      AppleSigninParams params) async {
    return exception2either(function: () async {
      final MeModel meModel =
          await remoteDataSource.signinWithApple(params.getBody());

      await localDateSoursce.cacheMe(meModel);
      return meModel;
    });
  }

  @override
  Future<Either<ExceptionData, void>> clear() async {
    return exception2either(function: () async {
      await localDateSoursce.clear();
    });
  }
}
