import 'package:crossworduel/features/profile/domain/usecases/refresh_me_usecase.dart';
import 'package:crossworduel/features/unauth/domain/entities/me_entity.dart';
import 'package:crossworduel/features/unauth/domain/usecases/get_me_usecase.dart';
import 'package:crossworduel/features/unauth/domain/usecases/logout_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crossworduel/core/usecases/no_params.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetMeUsecase getMe;
  final LogoutUsecase logout;
  final RefreshMeUsecase refreshMe;

  MeEntity? currentUser;

  AuthBloc({
    required this.getMe,
    required this.logout,
    required this.refreshMe,
  }) : super(LoadingAuthState()) {
    on<AuthEvent>((event, emit) async {
      // App first loaded
      if (event is AppStartedAuthEvent) {
        emit(LoadingAuthState());
        final result = await getMe(const NoParams());
        emit(result.fold(
          (failure) {
            return UnauthenticatedAuthState();
          },
          (meEntity) {
            currentUser = meEntity;
            return AuthenticatedAuthState(me: meEntity);
          },
        ));
      }

      // App login mechanism, we store user dataa
      if (event is LogInAuthEvent) {
        currentUser = event.me;
        emit(AuthenticatedAuthState(me: event.me));
      }

      // App logout mechanism
      if (event is LogOutAuthEvent) {
        final result = await logout(const NoParams());
        emit(result.fold(
          (failure) {
            return state;
          },
          (success) {
            currentUser = null;
            return UnauthenticatedAuthState();
          },
        ));
      }

      if (event is RefreshAuthEvent) {
        print("START --- ");
        final result = await refreshMe(NoParams());
        print("RESULT --- $result");
        emit(result.fold(
          (failure) => state,
          (meEntity) {
            currentUser = meEntity;
            return AuthenticatedAuthState(me: meEntity);
          },
        ));
      }

      // modify settings
      if (event is SyncWithCacheAuthEvent) {
        final result = await getMe(const NoParams());
        emit(result.fold(
          (failure) {
            return UnauthenticatedAuthState();
          },
          (meEntity) {
            currentUser = meEntity;
            return AuthenticatedAuthState(me: meEntity);
          },
        ));
      }
    });
  }

  void signout() {
    add(LogOutAuthEvent());
  }
}
