import 'package:dartz/dartz.dart';
import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:crossworduel/features/unauth/domain/entities/me_entity.dart';
import 'package:crossworduel/features/unauth/domain/usecases/apple_signin_usecase.dart';
import 'package:crossworduel/features/unauth/domain/usecases/signin_usecase.dart';
import 'package:crossworduel/features/unauth/domain/usecases/google_signin_usecase.dart';

abstract class UnauthRepositoryContract {
  /// This will check if user is authenticated or not
  /// if user not exist in local storage [Failure will be risen]
  Future<Either<ExceptionData, MeEntity>> getMe();

  /// User will sigin up with given data
  /// if user not sign up earlier [Failure will be risen]
  /// to Signup fiest
  Future<Either<ExceptionData, MeEntity>> signin(SigninParams signinParams);

  /// User will signin with google account
  Future<Either<ExceptionData, MeEntity>> signinWithGoogle(
      GoogleSigninParams params);

  // User will signin with apple account
  Future<Either<ExceptionData, MeEntity>> signinWithApple(
      AppleSigninParams params);

  Future<Either<ExceptionData, void>> clear();
}
