import 'package:crossworduel/features/unauth/domain/usecases/cach_me_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:crossworduel/core/exception/exception2either.dart';
import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:crossworduel/features/unauth/data/datasources/unauth_local_data_source.dart';
import 'package:crossworduel/features/unauth/domain/entities/me_entity.dart';
import 'package:crossworduel/features/unauth/domain/repositories/unauth_repository_contract.dart';
import 'package:crossworduel/features/unauth/domain/usecases/apple_signin_usecase.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UnauthRepositoryImpl implements UnauthRepositoryContract {
  final UnauthLocalDataSourceContract localDateSoursce;
  final SupabaseClient supabaseClient;
  final GoogleSignIn googleSignIn;

  UnauthRepositoryImpl({
    required this.localDateSoursce,
    required this.supabaseClient,
    required this.googleSignIn,
  });

  @override
  Future<Either<ExceptionData, MeEntity>> getMe() async =>
      exception2either<MeEntity>(function: () async {
        return localDateSoursce.getMe();
      });

  @override
  Future<Either<ExceptionData, MeEntity>> signinWithGoogle() async {
    return exception2either(function: () async {
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;
      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }

      AuthResponse response = await supabaseClient.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      if (response.session != null) {
        final MeEntity meEntit = MeEntity.fromUser(response.session!.user);
        await localDateSoursce.cacheMe(meEntit);
        return meEntit;
      } else {
        throw "Sign in failed";
      }
    });
  }

  @override
  Future<Either<ExceptionData, MeEntity>> signinWithApple(
      AppleSigninParams params) async {
    return exception2either(function: () async {
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;
      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }

      AuthResponse response = await supabaseClient.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      if (response.session != null) {
        final MeEntity meEntit = MeEntity.fromUser(response.session!.user);
        await localDateSoursce.cacheMe(meEntit);
        return meEntit;
      } else {
        throw "Sign in failed";
      }
    });
  }

  @override
  Future<Either<ExceptionData, void>> clear() async {
    return exception2either(function: () async {
      // Sign out from Google
      await googleSignIn.signOut();
      // Sign out from Supabase
      await supabaseClient.auth.signOut();
      await localDateSoursce.clear();
    });
  }

  @override
  Future<Either<ExceptionData, MeEntity>> cacheMe(CacheMeParams params) async {
    return exception2either(function: () async {
      await localDateSoursce.cacheMe(params.me);
      return params.me;
    });
  }
}
