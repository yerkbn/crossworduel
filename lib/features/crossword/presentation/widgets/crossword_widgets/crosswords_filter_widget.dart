import 'package:crossworduel/core/design-system/bottom-sheet/custom_modal_bottom_sheet.dart';
import 'package:crossworduel/core/design-system/label/label_widget.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/crossword/domain/entities/crosswords_filter_entity.dart';
import 'package:crossworduel/features/crossword/presentation/bloc/crosswords_filter/crosswords_filter_cubit.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword_bottom_sheet/difficulty_bottom_sheet.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword_bottom_sheet/language_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CrosswordsFilterWidget extends StatelessWidget {
  const CrosswordsFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CrosswordsFilterCubit, CrosswordsFilterEntity>(
      bloc: globalSL<CrosswordsFilterCubit>(),
      builder: (_, CrosswordsFilterEntity state) {
        return Row(
          children: [
            LabelWidget(
              text: state.language.toUpperCase(),
              height: 28,
              paddingFactor: 1.2,
              imagePath: "assets/icons/${state.language}.png",
              onPressed: () {
                showCustomModalBottomSheet(context, LanguageBottomSheet());
              },
            ),
            6.pw,
            LabelWidget(
              text: state.difficulty.toUpperCase(),
              height: 28,
              paddingFactor: 1.2,
              onPressed: () {
                showCustomModalBottomSheet(context, DifficultyBottomSheet());
              },
              color: CrosswordsFilterEntity.getLightColor(
                  context, state.difficulty),
              borderColor: CrosswordsFilterEntity.getHardColor(
                  context, state.difficulty),
            ),
          ],
        );
      },
    );
  }
}
