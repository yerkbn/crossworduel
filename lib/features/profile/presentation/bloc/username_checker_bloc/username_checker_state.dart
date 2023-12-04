part of 'username_checker_bloc.dart';

abstract class UsernameCheckerState extends Equatable {
  const UsernameCheckerState();

  @override
  List<Object> get props => [];
}

class UsernameCheckerInitial extends UsernameCheckerState {}

class CheckingUsernameState extends UsernameCheckerState {}

class FailureUsernameState extends UsernameCheckerState {
  final String message;

  const FailureUsernameState({required this.message});

  @override
  List<Object> get props => [message];
}

class SuccessUsernameState extends UsernameCheckerState {}
