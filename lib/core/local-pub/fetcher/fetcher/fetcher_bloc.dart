import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crossworduel/core/usecases/params_parent.dart';
import 'package:crossworduel/core/usecases/usecase.dart';

part 'fetcher_event.dart';
part 'fetcher_state.dart';

class FetcherBloc<T> extends Bloc<FetcherEvent, FetcherState> {
  final UseCase<T, ParamsParent> fetcherUseCase;

  FetcherBloc({required this.fetcherUseCase}) : super(InitialFetcherState()) {
    on<StartFetcherEvent>(onStart);
    on<RefreshFetcherEvent>(onRefresh);
    on<EditFetcherEvent<T>>(onEdit);
  }

  Future<void> onStart(
      StartFetcherEvent event, Emitter<FetcherState> emit) async {
    emit(LoadingFetcherState());
    await _fetch(event.params, emit);
  }

  Future<void> onRefresh(
      RefreshFetcherEvent event, Emitter<FetcherState> emit) async {
    emit(RefreshFetcherState(result: event.result));
    await _fetch(event.params, emit);
  }

  Future<void> onEdit(
      EditFetcherEvent<T> event, Emitter<FetcherState> emit) async {
    emit(SuccessFetcherState(result: event.data));
  }

  Future<void> _fetch(ParamsParent params, Emitter<FetcherState> emit) async {
    final result = await fetcherUseCase(params);
    result.fold(
      (failure) {
        print("FETCHER :: $failure");
        emit(FailureFetcherState(error: "$failure"));
      },
      (entity) {
        emit(SuccessFetcherState<T>(result: entity));
      },
    );
  }
}
