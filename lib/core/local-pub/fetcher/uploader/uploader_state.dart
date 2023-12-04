part of 'uploader_bloc.dart';

@immutable
abstract class UploaderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DefaultUploaderState extends UploaderState {}

class LoadingUploaderState extends UploaderState {}

class FailureUploaderState extends UploaderState {
  final String message;

  FailureUploaderState(this.message);
}

class SuccessUploaderState<T> extends UploaderState {
  final T result;

  SuccessUploaderState({required this.result});

  @override
  List<Object?> get props => [result];
}
