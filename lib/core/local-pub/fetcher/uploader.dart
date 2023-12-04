import 'package:crossworduel/core/local-pub/fetcher/uploader/uploader_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crossworduel/core/usecases/params_parent.dart';
import 'package:crossworduel/core/usecases/usecase.dart';

class Uploader<T> {
  final UseCase<T, ParamsParent> useCase;
  final Function(BuildContext context, UploaderState state)? listener;
  final Widget Function(bool isLoading) buildChild;
  // local usage
  final UploaderBloc<T> _uploaderBloc;

  Uploader({
    required this.useCase,
    required this.buildChild,
    this.listener,
  }) : _uploaderBloc = UploaderBloc<T>(useCase: useCase);

  void dispose() {
    _uploaderBloc.close();
  }

  /// this update build method with new
  /// fetched data, it can be called from outside
  void upload(ParamsParent params) {
    _uploaderBloc.add(UploadUploaderEvent(params: params));
  }

  Widget build(BuildContext context) {
    return BlocConsumer(
        listener: this.listener ?? (_, __) {},
        bloc: _uploaderBloc,
        builder: (BuildContext context, UploaderState state) =>
            buildChild(state is LoadingUploaderState));
  }
}
