import 'package:crossworduel/core/usecases/no_params.dart';
import 'package:crossworduel/features/unauth/domain/usecases/apple_signin_usecase.dart';
import 'package:crossworduel/features/unauth/domain/usecases/google_signin_usecase.dart';
import 'package:crossworduel/features/unauth/presentation/bloc/auth/auth_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final AuthBloc authBloc;
  final GoogleSigninUsecase googleSignin;
  final AppleSigninUsecase appleSigninUsecase;

  SigninBloc({
    required this.authBloc,
    required this.googleSignin,
    required this.appleSigninUsecase,
  }) : super(InitialSigninState()) {
    on<SigninEvent>((event, emit) async {
      if (event is ActivateSigninEvent) {
        // final String pushToken =
        //     await PushNotificationRepo().getNotificationToken();
        emit(LoadingSigninState(from: event.from));
        if (event.isGoogle) {
          final result = await googleSignin(const NoParams());

          emit(result.fold(
            (failure) {
              print("FAILURE --- $failure");
              return FailureSigninState(message: failure.description);
            },
            (meEntity) {
              authBloc.add(LogInAuthEvent(me: meEntity));
              return InitialSigninState();
            },
          ));
        } else if (event.isApple) {
          final result = await appleSigninUsecase(const NoParams());
          emit(result.fold(
            (failure) {
              return FailureSigninState(message: failure.description);
            },
            (meEntity) {
              authBloc.add(LogInAuthEvent(me: meEntity));
              return InitialSigninState();
            },
          ));
        }
      }
      // as remote control to control outside from Apple or Google signin
      if (event is LoadingSigninEvent) {
        emit(LoadingSigninState(from: event.from));
      }
      if (event is FailureSigninEvent) {
        emit(FailureSigninState(message: event.message));
      }
    });
  }
}
