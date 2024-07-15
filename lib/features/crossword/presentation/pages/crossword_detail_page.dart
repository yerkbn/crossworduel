import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/appbar/main_app_bar.dart';
import 'package:crossworduel/core/design-system/button/custom_button.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/core/local-pub/fetcher/fetcher.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/crossword/domain/entities/crossword_entity.dart';
import 'package:crossworduel/features/crossword/domain/usecases/get_crossword_usecase.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword_widgets/crossword_container_widget.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword_widgets/leaderboard_widget.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword_widgets/rating_widget.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword_run/crossword_grid_widget.dart';
import 'package:crossworduel/gen/assets.gen.dart';
import 'package:crossworduel/navigation/auth_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CrosswordDetailPage extends StatefulWidget {
  final CrosswordEntity crosswordEntity;
  const CrosswordDetailPage({super.key, required this.crosswordEntity});

  @override
  State<CrosswordDetailPage> createState() => _CrosswordDetailPageState();
}

class _CrosswordDetailPageState extends State<CrosswordDetailPage> {
  late final Fetcher<CrosswordEntity> _fetcher;

  @override
  void initState() {
    super.initState();
    _fetcher = Fetcher<CrosswordEntity>(
      fetcherUseCase: globalSL<GetCrosswordUsecase>(),
      buildSuccess: buildSuccess,
      initalParams: GetCrosswordParams(crosswordId: widget.crosswordEntity.id),
    );
    _fetcher.fetch();
  }

  Widget buildSuccess(CrosswordEntity crosswordEntity) {
    return SingleChildScrollView(
      child: CustomContainer(
        paddingVertical: 0,
        child: Column(
          children: [
            CrosswordContainerWidget(
                isDetail: true, crosswordEntity: crosswordEntity),
            16.ph,
            CrosswordGridWidget(crossword: crosswordEntity),
            16.ph,
            getBottomButtons(context),
            16.ph,
            RatingWidget(crosswordEntity: crosswordEntity),
            16.ph,
            LeaderboardWidget(crosswordEntity: crosswordEntity),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);

    return Scaffold(
        appBar: MainAppBar(withBack: true),
        backgroundColor: theme.backgroundColor2,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: _fetcher.build(context));
  }

  Widget getBottomButtons(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomButton.h2(
            title: "START CROSSWORD",
            child: Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: Assets.icons.pen.image(height: 20.h),
            ),
            width: 216.w,
            onPressed: () {
              globalSL<AuthNavigation>()
                  .globalRouter
                  .push(AuthNavigation.run, extra: widget.crosswordEntity)
                  .then((_) => _fetcher.fetch());
            }),
        6.pw,
        CustomContainer(
          color: theme.backgroundColor3,
          paddingHorizantal: 6.h,
          paddingVertical: 6.h,
          topMargin: 0,
          borderRadius: 8.h,
          child: Icon(
            Icons.block,
            color: Colors.white,
            size: 24.h,
          ),
          onPressed: () {},
        ),
        6.pw,
        CustomContainer(
          color: theme.backgroundColor3,
          paddingHorizantal: 6.h,
          paddingVertical: 6.h,
          topMargin: 0,
          borderRadius: 8.h,
          child: Icon(
            Icons.ios_share,
            color: Colors.white,
            size: 24.h,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
