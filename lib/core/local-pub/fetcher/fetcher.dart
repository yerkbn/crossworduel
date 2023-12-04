import 'package:crossworduel/core/design-system/loading/custom_loading.dart';
import 'package:crossworduel/core/design-system/states/failure/custom_failure.dart';
import 'package:crossworduel/core/design-system/states/loading/shimmer_loading.dart';
import 'package:crossworduel/core/local-pub/fetcher/fetcher/fetcher_bloc.dart';
import 'package:crossworduel/core/usecases/no_params.dart';
import 'package:crossworduel/core/usecases/params_parent.dart';
import 'package:crossworduel/core/usecases/usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// This is simple module is responsibile for fetching elements
/// and provide it to provided class and handle all View cases
/// [LOADING, ERROR, SUCCESS]

class Fetcher<T> {
  final UseCase<T, ParamsParent> fetcherUseCase;
  final Widget Function(T feet) buildSuccess;
  final bool isRefreshIsEnabled;
  final Widget? loadingShimmer;
  final ParamsParent initalParams;
  final bool showFailure;
  final bool outsideOfShimmer;
  final Function(T feet)? successEntity;

  // local usage
  final RefreshController _refreshController = RefreshController();
  final FetcherBloc<T> _fetcherBloc;
  T? _data;

  Fetcher({
    required this.buildSuccess,
    required this.fetcherUseCase,
    this.loadingShimmer,
    this.isRefreshIsEnabled = true,
    this.outsideOfShimmer = false,
    this.initalParams = const NoParams(),
    this.showFailure = true,
    this.successEntity,
  }) : _fetcherBloc = FetcherBloc<T>(fetcherUseCase: fetcherUseCase);

  void dispose() {
    _fetcherBloc.close();
  }

  void add(T data) {
    _fetcherBloc.add(EditFetcherEvent<T>(data: data));
  }

  /// this update build method with new
  /// fetched data, it can be called from outside
  void fetch({ParamsParent? params}) {
    _fetcherBloc.add(StartFetcherEvent(params: params ?? initalParams));
  }

  Widget build(BuildContext context) {
    if (isRefreshIsEnabled) {
      return SmartRefresher(
        controller: _refreshController,
        onRefresh: () {
          _fetcherBloc
              .add(RefreshFetcherEvent(result: _data, params: initalParams));
        },
        child: _buildContent(context),
      );
    }

    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    return BlocConsumer(
        listener: (BuildContext context, FetcherState state) {
          if (isRefreshIsEnabled) {
            if (!((state is LoadingFetcherState) ||
                (state is RefreshFetcherState))) {
              _refreshController.refreshCompleted();
            }
          }

          if (state is SuccessFetcherState<T>) {
            if (successEntity != null) {
              // ignore: prefer_null_aware_method_calls
              successEntity!(state.result);
            }
          }
        },
        bloc: _fetcherBloc,
        builder: (BuildContext context, FetcherState state) {
          if (state is LoadingFetcherState || state is InitialFetcherState) {
            if (loadingShimmer != null) {
              return outsideOfShimmer
                  ? loadingShimmer!
                  : Shimmer(child: loadingShimmer);
            }
            return const CustomLoading();
          }
          if (state is FailureFetcherState) {
            // return Container(color: Colors.red, child: Text("sss"),);
            _data = null;
            if (!showFailure) {
              if (loadingShimmer != null) {
                return outsideOfShimmer
                    ? loadingShimmer!
                    : Shimmer(child: loadingShimmer);
              }
              return const SizedBox.shrink();
            }

            return CustomFailure(
              onTap: () {
                fetch();
              },
              status: FailureStatus.h3,
            );
          }
          if (state is SuccessFetcherState<T>) {
            _data = state.result;
            return buildSuccess(state.result);
          }
          if (state is RefreshFetcherState) {
            if (state.result == null) {
              return CustomFailure(
                onTap: () {
                  fetch();
                },
              );
            } else {
              return buildSuccess(state.result as T);
            }
          }
          return Container();
        });
  }

  T get data => _data as T;

  void modify(T data) => add(data);
}
