import 'package:dartz/dartz.dart';
import 'package:crossworduel/core/exception/instruction_exception.dart';
import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:crossworduel/core/usecases/no_params.dart';
import 'package:crossworduel/core/usecases/params_parent.dart';
import 'package:crossworduel/core/usecases/usecase.dart';
import 'package:crossworduel/features/unauth/domain/entities/me_entity.dart';
import 'package:crossworduel/features/unauth/domain/repositories/unauth_repository_contract.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class GoogleSigninUsecase implements UseCase<MeEntity, NoParams> {
  final UnauthRepositoryContract _repositoryContract;

  GoogleSigninUsecase(this._repositoryContract);

  @override
  Future<Either<ExceptionData, MeEntity>> call(NoParams params) async {
    try {
      // ! uncomment me
      // final GoogleSignIn controller = GoogleSignIn(
      //   scopes: <String>['email'],
      // );

      // /// Before authentication we disconnect or log out from old account
      // if (await controller.isSignedIn()) {
      //   await controller.disconnect();
      // }
      // final GoogleSignInAccount? rawUser = await controller.signIn();
      // if (rawUser == null) {
      //   throw 'user_not_given';
      // }
      // final GoogleSignInAuthentication googleAuth =
      //     await rawUser.authentication;

      // final String token = await getToken();
      // return _repositoryContract.signinWithGoogle(GoogleSigninParams(
      //     token: googleAuth.accessToken ?? '', pushToken: token));
      return _repositoryContract
          .signinWithGoogle(const GoogleSigninParams(token: '', pushToken: ""));
    } catch (err) {
      return Left(ConfigurationInsException.parseMap({"google signin": err}));
    }
  }

  Future<String> getToken() async {
    try {
      final settings = await FirebaseMessaging.instance.requestPermission();
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
      } else {
        return '';
      }

      final FirebaseMessaging messaging = FirebaseMessaging.instance;
      final String? token = await messaging.getToken();
      print("TOKEN IS $token");
      return token ?? '';
    } catch (err) {
      print("####### ERROR IN GETTING TOKEN $err");
      return '';
    }
  }
}

class GoogleSigninParams extends ParamsParent {
  final String token;
  final String pushToken;

  const GoogleSigninParams({
    required this.token,
    required this.pushToken,
  });

  @override
  List<Object?> get props => [token];

  @override
  Map<String, dynamic> getBody({Map<String, dynamic> params = const {}}) =>
      {"token": token, "pushToken": pushToken};
}
