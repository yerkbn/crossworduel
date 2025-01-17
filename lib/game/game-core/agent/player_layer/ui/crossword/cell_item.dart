import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/game/domain/entities/cell_entity.dart';
import 'package:crossworduel/game/game-core/agent/player_layer/player_event.dart';
import 'package:crossworduel/game/game-core/game/bloc/game_bloc.dart';
import 'package:crossworduel/game/game-core/sizer/sizer.dart';
import 'package:flutter/material.dart';

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
      width: Sizer().getWidth(28),
      height: Sizer().getWidth(28),
      topMargin: 0,
      onPressed: () {
        globalSL<GameBloc>().add(CrosswordTapGameEvent(point: cell.point));
      },
      borderRadius: Sizer().getWidth(4),
      color: backgroundColor,
      borderColor: borderColor,
      paddingSize: 0,
      child: Text(cell.currentValue.toUpperCase(),
          style: theme.headline2.copyWith(
            color: Colors.black,
            fontSize: Sizer().getSp(14),
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
          borderRadius: BorderRadius.circular(Sizer().getWidth(4))),
    );
  }
}
