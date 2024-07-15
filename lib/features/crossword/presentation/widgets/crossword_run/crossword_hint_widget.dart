import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/crossword/domain/entities/crossword_entity.dart';
import 'package:crossworduel/features/crossword/presentation/bloc/crossword_run/crossword_run_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CrosswordHintWidget extends StatelessWidget {
  final CrosswordEntity crosswordEntity;
  const CrosswordHintWidget({super.key, required this.crosswordEntity});

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomContainer(
          color: theme.backgroundColor3,
          borderColor: theme.backgroundColor4,
          paddingSize: 8,
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: theme.textColor1,
            size: 16.h,
          ),
          onPressed: () {
            globalSL<CrosswordRunCubit>().nextPrev(false);
          },
        ),
        CustomContainer(
            paddingSize: 8,
            color: theme.backgroundColor3,
            width: 254,
            child: Text(
              "${crosswordEntity.getActiveSpan!.clue} : ${crosswordEntity.getActiveSpan!.answer}",
              textAlign: TextAlign.center,
              style: theme.headline4
                  .copyWith(color: theme.textColor1, fontSize: 12.sp),
            )),
        CustomContainer(
          color: theme.backgroundColor3,
          borderColor: theme.backgroundColor4,
          paddingSize: 8,
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            color: theme.textColor1,
            size: 16.h,
          ),
          onPressed: () {
            globalSL<CrosswordRunCubit>().nextPrev(true);
          },
        ),
      ],
    );
  }
}
