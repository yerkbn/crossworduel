part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {}

class AppStartedAuthEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class LogInAuthEvent extends AuthEvent {
  final MeEntity me;

  LogInAuthEvent({required this.me});

  @override
  List<Object> get props => [me];
}

class LogOutAuthEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class SyncWithCacheAuthEvent extends AuthEvent {
  SyncWithCacheAuthEvent();

  @override
  List<Object> get props => [];
}

class RefreshAuthEvent extends AuthEvent {
  RefreshAuthEvent();

  @override
  List<Object> get props => [];
}
