import 'package:crossworduel/core/local-pub/fetcher/fetcher.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/profile/domain/entities/history_entity.dart';
import 'package:crossworduel/features/profile/domain/usecases/get_history_usecase.dart';
import 'package:crossworduel/features/profile/presentation/bloc/refresh/refresh_bloc.dart';
import 'package:crossworduel/features/profile/presentation/widgets/statistics/level_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatisticsWidget extends StatefulWidget {
  const StatisticsWidget({super.key});

  @override
  State<StatisticsWidget> createState() => _StatisticsWidgetState();
}

class _StatisticsWidgetState extends State<StatisticsWidget> {
  late final Fetcher<List<HistoryEntity>> _fetcher;
  @override
  void initState() {
    super.initState();
    _fetcher = Fetcher<List<HistoryEntity>>(
      fetcherUseCase: globalSL<GetHistoryUsecase>(),
      buildSuccess: _buildSuccess,
      isRefreshIsEnabled: false,
    );
    _fetcher.fetch();
  }

  Widget _buildSuccess(List<HistoryEntity> items) {
    int winsCnt = 0;
    for (HistoryEntity h in items) {
      if (h.meDelta > 0) {
        winsCnt++;
      }
    }

    int level = winsCnt ~/ 100 + 1;
    String levelName = "BABY";
    if (level < 5) {
      List<String> lvls = [
        "BABY",
        "BABY",
        "PRO",
        "EXPERT",
        "MASTER",
      ];
      levelName = lvls[level];
    } else {
      levelName = "LEGEND";
    }

    return LevelItemWidget(
      level: level,
      levelName: levelName,
      wins: winsCnt - ((winsCnt ~/ 100) * 100),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RefreshBloc, RefreshState>(
        bloc: globalSL<RefreshBloc>(),
        listener: (_, RefreshState state) {
          if (state is RunRefreshState) {
            _fetcher.fetch();
          }
        },
        child: SizedBox(
          width: 324.w,
          child: _fetcher.build(context),
        ));
  }
}
