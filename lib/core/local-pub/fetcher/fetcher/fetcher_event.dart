part of 'fetcher_bloc.dart';

abstract class FetcherEvent<T> extends Equatable {
  const FetcherEvent();
}

class StartFetcherEvent<T> extends FetcherEvent {
  final ParamsParent params;

  const StartFetcherEvent({required this.params});
  @override
  List<Object> get props => [params];
}

class RefreshFetcherEvent<T> extends FetcherEvent {
  final T result;
  final ParamsParent params;

  const RefreshFetcherEvent({required this.result, required this.params});

  @override
  List<Object?> get props => [result, params];
}

class EditFetcherEvent<T> extends FetcherEvent {
  final T data;

  const EditFetcherEvent({required this.data});
  @override
  List<Object?> get props => [data];
}
