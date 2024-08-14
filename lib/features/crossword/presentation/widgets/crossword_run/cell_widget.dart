import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/crossword/domain/entities/cell_entity.dart';
import 'package:crossworduel/features/crossword/presentation/bloc/crossword_run/crossword_run_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CellWidget extends StatelessWidget {
  final CellEntity cell;
  const CellWidget({
    super.key,
    required this.cell,
  });

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    Color backgroundColor = theme.backgroundColor3;
    Color borderColor = theme.backgroundColor4;
    Color textColor = Colors.white;
    if (cell.isCurrent) {
      backgroundColor = theme.yellowLightColor;
      borderColor = theme.yellowHardColor;
      textColor = Colors.black;
    }
    if (cell.isCursive) {
      backgroundColor = theme.blueLightColor;
      borderColor = theme.blueHardColor;
    }
    if (cell.isValid) {
      backgroundColor = theme.greenLightColor;
      borderColor = theme.greenHardColor;
      ;
    }
    return CustomContainer(
      width: 28.w,
      height: 28.w,
      topMargin: 0,
      onPressed: () {
        globalSL<CrosswordRunCubit>().onCellTap(cell.point);
      },
      borderRadius: 6.w,
      color: backgroundColor,
      borderColor: borderColor,
      paddingSize: 0,
      child: Text(cell.currentValue.toUpperCase(),
          style: theme.headline2.copyWith(
            color: textColor,
            fontSize: 14.sp,
          )),
    );
  }
}

class EmptyCellWidget extends StatelessWidget {
  const EmptyCellWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Container(
      width: 28.w,
      height: 28.w,
      decoration: BoxDecoration(
          color: theme.backgroundColor1,
          border: Border.all(color: theme.backgroundColor3),
          borderRadius: BorderRadius.circular(6.w)),
    );
  }
}
