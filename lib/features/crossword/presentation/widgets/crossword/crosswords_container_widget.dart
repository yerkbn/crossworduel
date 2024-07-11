import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/core/local-pub/fetcher/fetcher.dart';
import 'package:crossworduel/core/normalizer/normalizer.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/crossword/domain/entities/crossword_entity.dart';
import 'package:crossworduel/features/crossword/domain/usecases/get_crosswords_usecase.dart';
import 'package:crossworduel/features/crossword/presentation/bloc/category/category_bloc.dart';
import 'package:crossworduel/features/crossword/presentation/data/main_switch_data.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword/crossword_container_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CrosswordsContainerWidget extends StatefulWidget with Normalizer {
  final PageController pageController;

  const CrosswordsContainerWidget({
    super.key,
    required this.pageController,
  });

  @override
  State<CrosswordsContainerWidget> createState() =>
      _CrosswordsContainerWidgetState();
}

class _CrosswordsContainerWidgetState extends State<CrosswordsContainerWidget> {
  late final Fetcher<List<CrosswordEntity>> _myFetcher;
  late final Fetcher<List<CrosswordEntity>> _worldFetcher;
  late final Fetcher<List<CrosswordEntity>> _historyFetcher;

  @override
  void initState() {
    _myFetcher = Fetcher<List<CrosswordEntity>>(
      fetcherUseCase: globalSL<GetCrosswordUsecase>(),
      buildSuccess: buildSuccess,
      initalParams: GetCrosswordParams(type: CrosswordsTypEnum.My),
    );
    _myFetcher.fetch();
    _worldFetcher = Fetcher<List<CrosswordEntity>>(
      fetcherUseCase: globalSL<GetCrosswordUsecase>(),
      buildSuccess: buildSuccess,
      initalParams: GetCrosswordParams(type: CrosswordsTypEnum.World),
    );
    _worldFetcher.fetch();
    _historyFetcher = Fetcher<List<CrosswordEntity>>(
      fetcherUseCase: globalSL<GetCrosswordUsecase>(),
      buildSuccess: buildSuccess,
      initalParams: GetCrosswordParams(type: CrosswordsTypEnum.History),
    );
    _historyFetcher.fetch();
    super.initState();
  }

  @override
  void dispose() {
    _myFetcher.dispose();
    _worldFetcher.dispose();
    _historyFetcher.dispose();
    super.dispose();
  }

  Widget buildSuccess(List<CrosswordEntity> items) {
    return CustomContainer(
      paddingVertical: 0,
      topMargin: 0,
      borderRadius: 0,
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (CrosswordEntity item in items)
              CrosswordContainerWidget(crosswordEntity: item),
            32.ph,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: PageView(
      dragStartBehavior: DragStartBehavior.down,
      onPageChanged: (value) {
        globalSL.get<CategoryBloc>().add(
              SwitchCategoryEvent(
                  category: MainSwitchData.getCategoryByOrder(value)),
            );
      },
      controller: widget.pageController,
      children: [
        _myFetcher.build(context),
        _worldFetcher.build(context),
        _historyFetcher.build(context),
      ],
    ));
  }
}
