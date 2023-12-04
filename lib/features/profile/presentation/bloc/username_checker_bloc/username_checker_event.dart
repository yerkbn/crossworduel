part of 'username_checker_bloc.dart';

abstract class UsernameCheckerEvent extends Equatable {
  const UsernameCheckerEvent();

  @override
  List<Object> get props => [];
}

class CheckUsernameEvent extends UsernameCheckerEvent {
  final String username;

  const CheckUsernameEvent({required this.username});

  @override
  List<Object> get props => [username];
}
