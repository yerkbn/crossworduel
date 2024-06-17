import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/core/normalizer/normalizer.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/crossword/presentation/bloc/category/category_bloc.dart';
import 'package:crossworduel/features/crossword/presentation/data/main_switch_data.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword/crossword_container_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CrosswordsContainerWidget extends StatelessWidget with Normalizer {
  final PageController pageController;
  const CrosswordsContainerWidget({
    super.key,
    required this.pageController,
  });

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
      controller: pageController,
      children: [
        CustomContainer(
          paddingVertical: 0,
          topMargin: 0,
          borderRadius: 0,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CrosswordContainerWidget(),
                CrosswordContainerWidget(),
                CrosswordContainerWidget(),
                CrosswordContainerWidget(),
                CrosswordContainerWidget(),
                CrosswordContainerWidget(),
                32.ph,
              ],
            ),
          ),
        ),
        CustomContainer(
          paddingVertical: 0,
          topMargin: 0,
          borderRadius: 0,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CrosswordContainerWidget(),
                CrosswordContainerWidget(),
                CrosswordContainerWidget(),
                CrosswordContainerWidget(),
                CrosswordContainerWidget(),
                CrosswordContainerWidget(),
                32.ph,
              ],
            ),
          ),
        ),
        CustomContainer(
          paddingVertical: 0,
          topMargin: 0,
          borderRadius: 0,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CrosswordContainerWidget(),
                CrosswordContainerWidget(),
                CrosswordContainerWidget(),
                CrosswordContainerWidget(),
                CrosswordContainerWidget(),
                CrosswordContainerWidget(),
                32.ph,
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
