import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/util/sizer/sizer.dart';
import 'package:crossworduel/game/core/agent/player_layer/player_event.dart';
import 'package:crossworduel/game/core/game/bloc/game_bloc.dart';
import 'package:crossworduel/game/domain/entities/cell_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    Color borderColor = theme.backgroundColor2;
    if (cell.isCurrent) {
      backgroundColor = theme.primaryColor;
      borderColor = const Color(0xFF219653);
    }
    return CustomContainer(
      width: Sizer().getWidth(28),
      height: Sizer().getWidth(28),
      topMargin: 0,
      onPressed: () {
        BlocProvider.of<GameBloc>(context)
            .add(LetterTapGameEvent(index: cell.index));
      },
      borderRadius: 4.sp,
      color: backgroundColor,
      borderColor: borderColor,
      paddingSize: 0,
      child: Text(cell.value.toUpperCase(),
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
      width: Sizer().getWidth(28),
      height: Sizer().getWidth(28),
      decoration: BoxDecoration(
          color: theme.backgroundColor1,
          border: Border.all(color: theme.backgroundColor2.withOpacity(.6)),
          borderRadius: BorderRadius.circular(4.sp)),
    );
  }
}
