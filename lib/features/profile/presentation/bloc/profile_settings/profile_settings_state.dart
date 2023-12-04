part of 'profile_settings_bloc.dart';

abstract class ProfileSettingsState extends Equatable {
  final ProfileEditParams params;
  const ProfileSettingsState({required this.params});

  @override
  List<Object> get props => [];
}

class ProfileSettingsInitial extends ProfileSettingsState {
  const ProfileSettingsInitial({required super.params});
}

class LoadingProfileSettingsState extends ProfileSettingsState {
  const LoadingProfileSettingsState({required super.params});
}

class ProfileUpdatedSettingsState extends ProfileSettingsState {
  const ProfileUpdatedSettingsState({required super.params});
}

class FailureProfileSettingsState extends ProfileSettingsState {
  final String message;

  const FailureProfileSettingsState(
      {required this.message, required super.params});

  @override
  List<Object> get props => [message];
}

class SuccessProfileSettingsState extends ProfileSettingsState {
  const SuccessProfileSettingsState({required super.params});

  @override
  List<Object> get props => [];
}

class CheckingUsernameState extends ProfileSettingsState {
  const CheckingUsernameState({required super.params});
}

class UserDeletedState extends ProfileSettingsState {
  const UserDeletedState({required super.params});
}
