import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/button/custom_button.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/design-system/label/label_widget.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/crossword/domain/entities/crosswords_filter_entity.dart';
import 'package:crossworduel/features/crossword/presentation/bloc/crosswords_filter/crosswords_filter_cubit.dart';
import 'package:crossworduel/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DifficultyBottomSheet extends StatefulWidget {
  const DifficultyBottomSheet({super.key});

  @override
  State<DifficultyBottomSheet> createState() => _DifficultyBottomSheetState();
}

class _DifficultyBottomSheetState extends State<DifficultyBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);

    return BlocBuilder<CrosswordsFilterCubit, CrosswordsFilterEntity>(
        bloc: globalSL<CrosswordsFilterCubit>(),
        builder: (_, CrosswordsFilterEntity state) {
          return CustomContainer(
            paddingHorizantal: 16.w,
            paddingVertical: 0,
            width: double.infinity,
            child: Column(
              children: [
                for (DifficultyEnum df in DifficultyEnum.values)
                  buildSelectItem(
                    state.difficulty == df.name,
                    df,
                    CrosswordsFilterEntity.getLightColor(context, df.name),
                    CrosswordsFilterEntity.getHardColor(context, df.name),
                    theme.backgroundColor1,
                  ),
                8.ph,
                CustomButton.h2(
                  title: "SAVE",
                  width: 132.w,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: Assets.icons.pen.image(height: 22.h),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget buildSelectItem(
    bool isActive,
    DifficultyEnum df,
    Color backgroundColor,
    Color borderColor,
    Color textColor,
  ) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: LabelWidget(
          width: isActive ? double.infinity : 86,
          text: df.name.toUpperCase(),
          height: 32,
          paddingFactor: 1.2,
          onPressed: () {
            globalSL<CrosswordsFilterCubit>().changeDifficulty(df);
          },
          color: backgroundColor,
          borderColor: borderColor,
        ),
      ),
    );
  }
}
