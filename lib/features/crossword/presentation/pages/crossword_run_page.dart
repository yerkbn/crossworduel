import 'package:confetti/confetti.dart';
import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/button/custom_button.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/core/local-pub/fetcher/uploader.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/crossword/domain/entities/crossword_entity.dart';
import 'package:crossworduel/features/crossword/domain/usecases/finish_crossword_usecase.dart';
import 'package:crossworduel/features/crossword/presentation/bloc/crossword_run/crossword_run_cubit.dart';
import 'package:crossworduel/features/crossword/presentation/bloc/timer/timer_cubit.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword_run/crossword_hint_widget.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword_run/crossword_grid_widget.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword_run/crossword_run_app_bar.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword_widgets/rating_widget.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/keyboard/keyboard_widget.dart';
import 'package:crossworduel/gen/assets.gen.dart';
import 'package:crossworduel/navigation/auth_navigation.dart';
import 'package:dartz/dartz.dart' as dart;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CrosswordRunPage extends StatefulWidget {
  final CrosswordEntity crosswordEntity;
  CrosswordRunPage({super.key, required this.crosswordEntity});

  @override
  State<CrosswordRunPage> createState() => _CrosswordRunPageState();
}

class _CrosswordRunPageState extends State<CrosswordRunPage> {
  final TimerCubit _timerCubit = globalSL<TimerCubit>();
  late ConfettiController _controllerCenter;
  late Uploader<dart.None> _uploader;
  int _correctSpnCnt = 0;

  @override
  void initState() {
    super.initState();
    globalSL<CrosswordRunCubit>().init(widget.crosswordEntity);
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 1));
    _uploader = Uploader(
        useCase: globalSL<FinishCrosswordUsecase>(),
        buildChild: _buildUploader);
  }

  Widget _buildUploader(bool isLoading) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return CustomButton.h1(
        title: "CLOSE",
        isLoading: isLoading,
        color: theme.backgroundColor3,
        onPressed: () {
          globalSL<AuthNavigation>().globalRouter.pop();
        });
  }

  @override
  void dispose() {
    super.dispose();
    _controllerCenter.dispose();
  }

  void _triggerMediumImpact() {
    HapticFeedback.mediumImpact();
  }

  void _triggerHeavyImpact() {
    HapticFeedback.heavyImpact();
  }

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Scaffold(
      appBar: CrosswordRunAppBar(timerCubit: _timerCubit),
      backgroundColor: theme.backgroundColor2,
      body: Stack(
        children: [
          CustomContainer(
            paddingVertical: 0,
            child: BlocConsumer<CrosswordRunCubit, CrosswordRunState>(
              bloc: globalSL<CrosswordRunCubit>(),
              listener: (_, state) {
                if (state.crosswordEntity.isAllAnswered) {
                  _triggerHeavyImpact();
                  _controllerCenter.play();
                  _timerCubit.finish();
                  _uploader.upload(FinishCrosswordParams(
                      secondsElapsed: _timerCubit.getSecondsElapsed,
                      crosswordId: widget.crosswordEntity.id));
                }
                if (_correctSpnCnt < state.crosswordEntity.getCorrectSpnCnt) {
                  _triggerMediumImpact();
                  _controllerCenter.play();
                  _correctSpnCnt = state.crosswordEntity.getCorrectSpnCnt;
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    16.ph,
                    CrosswordGridWidget(crossword: state.crosswordEntity),
                    16.ph,
                    CrosswordHintWidget(crosswordEntity: state.crosswordEntity),
                    16.ph,
                    if (state.crosswordEntity.isAllAnswered)
                      _buildSuccessfullyFinish(state)
                    else
                      _buildRunning(state),
                  ],
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _controllerCenter,
              blastDirectionality: BlastDirectionality.explosive,
              minBlastForce: 10,
              numberOfParticles: 30,
              gravity: .4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRunning(CrosswordRunState state) {
    return Column(
      children: [
        CustomButton.h2(
            title: "EXTRA HINT",
            width: 184.w,
            child: Padding(
              padding: EdgeInsets.only(right: 4.w),
              child: Assets.icons.heart.image(height: 22.h),
            ),
            onPressed: () {}),
        16.ph,
        KeyboardWidget(),
      ],
    );
  }

  Widget _buildSuccessfullyFinish(CrosswordRunState state) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Column(
      children: [
        RatingWidget(crosswordEntity: state.crosswordEntity),
        16.ph,
        RichText(
          text: TextSpan(
              style: theme.headline1.copyWith(fontSize: 32.sp),
              children: [
                TextSpan(
                    text: "TIME: ",
                    style: TextStyle(
                        color: theme.backgroundColor4, fontSize: 26.sp)),
                TextSpan(
                    text: " ${_timerCubit.getSecondsElapsed} sec",
                    style: TextStyle(color: theme.greenLightColor)),
              ]),
        ),
        16.ph,
        _uploader.build(context)
      ],
    );
  }
}
