part of 'profile_settings_bloc.dart';

abstract class ProfileSettingsEvent extends Equatable {
  const ProfileSettingsEvent();

  @override
  List<Object> get props => [];
}

class InitProfileSettingsEvent extends ProfileSettingsEvent {
  final MeEntity me;

  const InitProfileSettingsEvent(this.me);
}

class UpdateParamsEvent extends ProfileSettingsEvent {
  final String? username;
  final bool? isPushEnabled;
  const UpdateParamsEvent({
    this.username,
    this.isPushEnabled,
  });

  @override
  List<Object> get props => [];
}

class UpdateProfileSettingsEvent extends ProfileSettingsEvent {
  final String username;
  final int avatarId;
  final int hatId;
  final bool isPushEnabled;
  final bool isSoundEnabled;
  final String language;
  const UpdateProfileSettingsEvent({
    required this.username,
    required this.avatarId,
    required this.hatId,
    required this.isPushEnabled,
    required this.isSoundEnabled,
    required this.language,
  });

  @override
  List<Object> get props =>
      [username, avatarId, hatId, isPushEnabled, isSoundEnabled, language];
}

class SaveProfileSettingsEvent extends ProfileSettingsEvent {
  final String username;
  const SaveProfileSettingsEvent({required this.username});
}

class DeleteProfileEvent extends ProfileSettingsEvent {}
