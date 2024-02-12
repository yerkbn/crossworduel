import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/core/local-pub/fetcher/fetcher.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/profile/domain/entities/history_entity.dart';
import 'package:crossworduel/features/profile/domain/usecases/get_history_usecase.dart';
import 'package:crossworduel/features/profile/presentation/bloc/refresh/refresh_bloc.dart';
import 'package:crossworduel/features/profile/presentation/widgets/history/history_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({super.key});

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<RefreshBloc, RefreshState>(
      bloc: globalSL<RefreshBloc>(),
      listener: (_, RefreshState state) {
        if (state is RunRefreshState) {
          _fetcher.fetch();
        }
      },
      child: _fetcher.build(context),
    );
  }

  Widget _buildSuccess(List<HistoryEntity> items) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    if (items.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: 16.h),
        child: Text(
          "EMPTY HISTORY",
          style: theme.headline3,
        ),
      );
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.ph,
          Text(
            "HISTORY",
            style: theme.headline3,
          ),
          for (final HistoryEntity item in items)
            HistoryItem(historyEntity: item),
        ],
      ),
    );
  }
}
