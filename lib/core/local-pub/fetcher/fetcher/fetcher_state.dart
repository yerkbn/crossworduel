part of 'fetcher_bloc.dart';

abstract class FetcherState extends Equatable {
  const FetcherState();
}

class InitialFetcherState extends FetcherState {
  @override
  List<Object> get props => [];
}

class LoadingFetcherState extends FetcherState {
  @override
  List<Object> get props => [];
}

class FailureFetcherState extends FetcherState {
  final String error;

  const FailureFetcherState({required this.error});
  @override
  List<Object> get props => [error];
}

class SuccessFetcherState<T> extends FetcherState {
  final T result;

  const SuccessFetcherState({required this.result});

  @override
  List<Object?> get props => [result];
}

class RefreshFetcherState<T> extends FetcherState {
  final T result;

  const RefreshFetcherState({required this.result});

  @override
  List<Object?> get props => [result];
}
