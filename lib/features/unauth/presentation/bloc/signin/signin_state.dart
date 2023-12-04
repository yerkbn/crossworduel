part of 'signin_bloc.dart';

abstract class SigninState extends Equatable {
  const SigninState();

  @override
  List<Object> get props => [];
}

class InitialSigninState extends SigninState {}

class LoadingSigninState extends SigninState {
  final String from;
  const LoadingSigninState({required this.from});
  @override
  List<Object> get props => [from];
}

class FailureSigninState extends SigninState {
  final String message;
  const FailureSigninState({required this.message});
}
