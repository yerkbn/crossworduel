import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'refresh_event.dart';
part 'refresh_state.dart';

class RefreshBloc extends Bloc<RefreshEvent, RefreshState> {
  RefreshBloc() : super(SilentRefreshState()) {
    on<RunRefreshEvent>((event, emit) {
      emit(RunRefreshState());
      emit(SilentRefreshState());
    });
  }

  void refresh() => add(RunRefreshEvent());
}
