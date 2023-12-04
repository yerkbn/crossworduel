import 'package:dartz/dartz.dart';
import 'package:crossworduel/core/exception/instruction_exception.dart';
import 'dart:io' show Platform;
import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:crossworduel/core/usecases/no_params.dart';
import 'package:crossworduel/core/usecases/params_parent.dart';
import 'package:crossworduel/core/usecases/usecase.dart';
import 'package:crossworduel/features/unauth/domain/entities/me_entity.dart';
import 'package:crossworduel/features/unauth/domain/repositories/unauth_repository_contract.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AppleSigninUsecase implements UseCase<MeEntity, NoParams> {
  final UnauthRepositoryContract _repositoryContract;

  AppleSigninUsecase(this._repositoryContract);

  @override
  Future<Either<ExceptionData, MeEntity>> call(NoParams params) async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      bool isAndroid = Platform.isAndroid;
      if (Platform.isIOS) {
        isAndroid = false;
      }

      final String token = await getToken();
      final AppleSigninParams params = AppleSigninParams(
          authorizationCode: credential.authorizationCode,
          isAndroid: isAndroid,
          pushToken: token);
      return await _repositoryContract.signinWithApple(params);
    } catch (err) {
      return Left(ConfigurationInsException.parseMap({"apple signin": err}));
    }
  }

  Future<String> getToken() async {
    final settings = await FirebaseMessaging.instance.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
    } else {
      return '';
    }

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    print("TOKEN IS $token");
    return token ?? '';
  }
}

class AppleSigninParams extends ParamsParent {
  final String authorizationCode;
  final bool isAndroid;
  final String pushToken;

  AppleSigninParams({
    required this.authorizationCode,
    required this.isAndroid,
    required this.pushToken,
  });

  @override
  Map<String, dynamic> getBody({Map<String, dynamic> params = const {}}) {
    return {
      "authorizationCode": authorizationCode,
      "isAndroid": isAndroid,
      "pushToken": pushToken,
    };
  }

  @override
  List<Object?> get props => [authorizationCode, isAndroid, pushToken];
}
