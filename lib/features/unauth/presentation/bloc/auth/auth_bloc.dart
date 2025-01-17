import 'package:crossworduel/core/usecases/no_params.dart';
import 'package:crossworduel/features/profile/domain/usecases/refresh_me_usecase.dart';
import 'package:crossworduel/features/unauth/domain/entities/me_entity.dart';
import 'package:crossworduel/features/unauth/domain/usecases/cach_me_usecase.dart';
import 'package:crossworduel/features/unauth/domain/usecases/get_me_usecase.dart';
import 'package:crossworduel/features/unauth/domain/usecases/logout_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetMeUsecase getMe;
  final LogoutUsecase logout;
  final RefreshMeUsecase refreshMe;
  final CacheMeUsecase cacheMe;

  MeEntity? currentUser;

  AuthBloc(
      {required this.getMe,
      required this.logout,
      required this.refreshMe,
      required this.cacheMe})
      : super(LoadingAuthState()) {
    on<AuthEvent>((event, emit) async {
      // App first loaded
      if (event is AppStartedAuthEvent) {
        emit(LoadingAuthState());
        final result = await getMe(const NoParams());
        emit(result.fold(
          (failure) {
            add(LogInAuthEvent(me: MeEntity.init()));
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
        final result = await refreshMe(const NoParams());
        emit(result.fold(
          (failure) => state,
          (meEntity) {
            currentUser = meEntity;
            return AuthenticatedAuthState(me: meEntity);
          },
        ));
      }

      if (event is EditAuthEvent) {
        if (currentUser != null) {
          final result =
              await cacheMe(CacheMeParams(me: event.edit(currentUser!)));
          emit(result.fold(
            (failure) => state,
            (meEntity) {
              currentUser = meEntity;
              return AuthenticatedAuthState(me: meEntity);
            },
          ));
        }
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
