part of 'signin_bloc.dart';

abstract class SigninEvent extends Equatable {
  const SigninEvent();

  @override
  List<Object> get props => [];
}

class ActivateSigninEvent extends SigninEvent {
  final String from; // this might be APPLE, GOOGLE
  const ActivateSigninEvent({required this.from});

  @override
  List<Object> get props => [from];

  bool get isGoogle => from == "GOOGLE";
  bool get isApple => from == "APPLE";
}

class LoadingSigninEvent extends SigninEvent {
  final String from; // this might be APPLE, GOOGLE
  const LoadingSigninEvent({required this.from});
}

class FailureSigninEvent extends SigninEvent {
  final String message;
  const FailureSigninEvent({required this.message});
}
