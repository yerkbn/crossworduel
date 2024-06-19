import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/game/domain/entities/cell_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CellItem extends StatelessWidget {
  final CellEntity cell;
  const CellItem({
    super.key,
    required this.cell,
  });

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    Color backgroundColor = theme.backgroundColor3;
    Color borderColor = theme.backgroundColor4;
    if (cell.isCurrent) {
      backgroundColor = const Color(0xFFFFFBD7);
      borderColor = const Color(0xFFF9E63E);
    }
    if (cell.isCursive) {
      backgroundColor = const Color(0xFFC1E1FF);
      borderColor = const Color(0xFF1F93FD);
    }
    if (cell.isValid) {
      backgroundColor = const Color(0xFF6FCF97);
      borderColor = const Color(0xFF219653);
    }
    return CustomContainer(
      width: 28.w,
      height: 28.w,
      topMargin: 0,
      onPressed: () {
        // globalSL<GameBloc>().add(CrosswordTapGameEvent(point: cell.point));
      },
      borderRadius: 6.w,
      color: backgroundColor,
      borderColor: borderColor,
      paddingSize: 0,
      child: Text(cell.currentValue.toUpperCase(),
          style: theme.headline2.copyWith(
            color: Colors.black,
            fontSize: 14.sp,
          )),
    );
  }
}

class EmptyCellItem extends StatelessWidget {
  const EmptyCellItem({super.key});

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
