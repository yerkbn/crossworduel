import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/core/usecases/no_params.dart';
import 'package:crossworduel/features/profile/domain/usecases/delete_user_usecase.dart';
import 'package:crossworduel/features/profile/domain/usecases/profile_edit_usecase.dart';
import 'package:crossworduel/features/unauth/domain/entities/me_entity.dart';
import 'package:crossworduel/features/unauth/presentation/bloc/auth/auth_bloc.dart';

part 'profile_settings_event.dart';
part 'profile_settings_state.dart';

class ProfileSettingsBloc
    extends Bloc<ProfileSettingsEvent, ProfileSettingsState> {
  final ProfileEditUsecase updateProfileSettingsUsecase;
  final DeleteUserUsecase deleteUserUsecase;
  final ProfileEditParams params =
      ProfileEditParams(username: "", isPushEnabled: false, avatar: "");

  ProfileSettingsBloc(
      {required this.updateProfileSettingsUsecase,
      required this.deleteUserUsecase})
      : super(ProfileSettingsInitial(
          params:
              ProfileEditParams(username: "", isPushEnabled: false, avatar: ""),
        )) {
    on<DeleteProfileEvent>((event, emit) async {
      emit(LoadingProfileSettingsState(params: params));
      final result = await deleteUserUsecase(const NoParams());
      emit(result.fold(
        (l) => FailureProfileSettingsState(
          message: l.description,
          params: params,
        ),
        (r) => UserDeletedState(params: params),
      ));
    });

    on<InitProfileSettingsEvent>(
      (event, emit) {
        params.update(
            newUsername: event.me.username,
            newIsPushEnabled: true,
            avatar: event.me.avatar);
        emit(ProfileUpdatedSettingsState(params: params));
      },
    );
    on<UpdateParamsEvent>(
      (event, emit) async {
        emit(LoadingProfileSettingsState(params: params));
        params.update(
          newUsername: event.username,
          newIsPushEnabled: event.isPushEnabled,
        );
        emit(ProfileUpdatedSettingsState(params: params));
      },
    );
    on<SaveProfileSettingsEvent>(
      (event, emit) async {
        emit(LoadingProfileSettingsState(params: params));
        params.update(newUsername: event.username);

        final result = await updateProfileSettingsUsecase(params);
        result.fold(
          (failure) => emit(FailureProfileSettingsState(
            message: failure.description,
            params: params,
          )),
          (success) {
            globalSL<AuthBloc>().add(AppStartedAuthEvent());
            emit(SuccessProfileSettingsState(params: params));
          },
        );
      },
    );
  }
}
