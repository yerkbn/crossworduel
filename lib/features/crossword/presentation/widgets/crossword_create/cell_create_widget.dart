import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/crossword/domain/entities/cell_entity.dart';
import 'package:crossworduel/features/crossword/domain/entities/point_entity.dart';
import 'package:crossworduel/features/crossword/presentation/bloc/crossword_create/crossword_create_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CellCreateWidget extends StatelessWidget {
  final CellEntity cell;
  const CellCreateWidget({super.key, required this.cell});

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
        globalSL<CrosswordCreateCubit>().onCellTap(cell.point);
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

class EmptyCellCreateWidget extends StatelessWidget {
  final PointEntity point;
  const EmptyCellCreateWidget({super.key, required this.point});

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return CustomContainer(
      width: 28.w,
      height: 28.w,
      topMargin: 0,
      onPressed: () {
        globalSL<CrosswordCreateCubit>().onCellTap(point);
      },
      borderRadius: 6.w,
      color: theme.backgroundColor2,
      borderColor: theme.backgroundColor3,
      child: Text("", style: theme.headline2.copyWith(fontSize: 14.sp)),
      paddingSize: 0,
    );
  }
}
