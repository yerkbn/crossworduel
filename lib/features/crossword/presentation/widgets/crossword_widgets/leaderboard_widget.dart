import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/design-system/image/custom_profile_widget.dart';
import 'package:crossworduel/core/design-system/label/label_widget.dart';
import 'package:crossworduel/core/design-system/states/empty/empty_widget.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/core/local-pub/fetcher/fetcher.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/crossword/domain/entities/crossword_entity.dart';
import 'package:crossworduel/features/crossword/domain/entities/crossword_finish_entity.dart';
import 'package:crossworduel/features/crossword/domain/usecases/get_crossword_leaders_usecase.dart';
import 'package:crossworduel/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaderboardWidget extends StatefulWidget {
  final CrosswordEntity crosswordEntity;
  const LeaderboardWidget({super.key, required this.crosswordEntity});

  @override
  State<LeaderboardWidget> createState() => _LeaderboardWidgetState();
}

class _LeaderboardWidgetState extends State<LeaderboardWidget> {
  late final Fetcher<List<CrosswordFinishEntity>> _fetcher;

  @override
  void initState() {
    super.initState();
    _fetcher = Fetcher<List<CrosswordFinishEntity>>(
      fetcherUseCase: globalSL<GetCrosswordLeadersUsecase>(),
      isRefreshIsEnabled: false,
      buildSuccess: buildSuccess,
      initalParams: GetCrosswordLeadersParams(
        crosswordId: widget.crosswordEntity.id,
      ),
    );
    _fetcher.fetch();
  }

  Widget buildSuccess(List<CrosswordFinishEntity> items) {
    if (items.isEmpty) {
      return EmptyWidget();
    } else {
      return Column(
        children: [
          for (int i = 0; i < items.length; i++) _buildItem(i, items[i]),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Top players",
          style: theme.headline1,
        ),
        _fetcher.build(context),
        42.ph,
      ],
    );
  }

  Widget _buildItem(int i, CrosswordFinishEntity item) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return CustomContainer(
        topMargin: 8.h,
        color: (i % 2 == 0) ? theme.backgroundColor3 : theme.backgroundColor2,
        paddingVertical: 2.h,
        borderRadius: 8.r,
        child: Row(
          children: [
            LabelWidget(
              text: (i + 1).toString(),
              imagePath: Assets.icons.order.path,
            ),
            8.pw,
            CustomProfileWidget(
              color: Colors.transparent,
              imageSize: 18,
              maxLength: 12,
              user: item.user,
            ),
            Expanded(child: 0.pw),
            LabelWidget(
              text: item.getSecondsElapsed,
              imagePath: Assets.icons.timer.path,
            ),
          ],
        ));
  }
}
