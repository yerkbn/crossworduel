import 'dart:async';
import 'package:crossworduel/core/usecases/params_parent.dart';
import 'package:crossworduel/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

part 'uploader_event.dart';
part 'uploader_state.dart';

class UploaderBloc<T> extends Bloc<UploaderEvent, UploaderState> {
  final UseCase<T, ParamsParent> useCase;

  /// This will store previous value. If refresh required
  /// we can just send prev value as placeholder
  T? prevValue;

  UploaderBloc({
    required this.useCase,
  }) : super(DefaultUploaderState()) {
    on<UploadUploaderEvent>(onUpload);
  }

  Future<void> onUpload(
    UploadUploaderEvent event,
    Emitter<UploaderState> emit,
  ) async {
    emit(LoadingUploaderState());
    final result = await useCase(event.params);
    result.fold(
      (failure) {
        print("Uploader :: $failure");
        emit(FailureUploaderState("$failure"));
        emit(DefaultUploaderState());
      },
      (entity) {
        emit(SuccessUploaderState<T>(result: entity));
        emit(DefaultUploaderState());
      },
    );
  }
}
