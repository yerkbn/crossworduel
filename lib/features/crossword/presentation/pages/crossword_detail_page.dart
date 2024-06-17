import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/appbar/main_app_bar.dart';
import 'package:crossworduel/core/design-system/button/custom_button.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword/crossword_container_widget.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword/leaderboard_widget.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword/rating_widget.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword_net/crossword_widget.dart';
import 'package:crossworduel/game/domain/entities/crossword_entity.dart';
import 'package:crossworduel/game/game-core/crossword/crossoword_picker_manager.dart';
import 'package:crossworduel/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CrosswordDetailPage extends StatefulWidget {
  const CrosswordDetailPage({super.key});

  @override
  State<CrosswordDetailPage> createState() => _CrosswordDetailPageState();
}

class _CrosswordDetailPageState extends State<CrosswordDetailPage> {
  late CrosswordPickerManager _picker;
  CrosswordEntity? _crossword;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    _picker = await CrosswordPickerManager.create();
    setState(() {
      _crossword = CrosswordEntity.parseMap({"spans": _picker.pick()});
    });
  }

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);

    return Scaffold(
        appBar: MainAppBar(withBack: true),
        backgroundColor: theme.backgroundColor2,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SingleChildScrollView(
          child: CustomContainer(
            paddingVertical: 0,
            child: Column(
              children: [
                CrosswordContainerWidget(isDetail: true),
                16.ph,
                if (_crossword != null) CrosswordWidget(crossword: _crossword!),
                16.ph,
                getBottomButtons,
                16.ph,
                RatingWidget(),
                16.ph,
                LeaderboardWidget(),
              ],
            ),
          ),
        ));
  }

  Widget get getBottomButtons {
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
            onPressed: () {}),
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
