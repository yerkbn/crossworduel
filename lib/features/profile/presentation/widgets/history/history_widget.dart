import 'package:crossworduel/core/local-pub/fetcher/fetcher.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/profile/domain/entities/history_entity.dart';
import 'package:crossworduel/features/profile/domain/usecases/get_history_usecase.dart';
import 'package:crossworduel/features/profile/presentation/widgets/history/history_item.dart';
import 'package:flutter/material.dart';

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
    return _fetcher.build(context);
  }

  Widget _buildSuccess(List<HistoryEntity> items) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final HistoryEntity item in items)
            HistoryItem(historyEntity: item),
        ],
      ),
    );
  }
}
