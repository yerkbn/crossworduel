import 'package:crossworduel/core/util/sizer/sizer.dart';
import 'package:crossworduel/game/core/agent/player_layer/ui/crossword/cell_item.dart';
import 'package:crossworduel/game/core/agent/player_layer/ui/crossword/static_grid.dart';
import 'package:crossworduel/game/domain/entities/cell_entity.dart';
import 'package:crossworduel/game/domain/entities/crossword_entity.dart';
import 'package:flutter/material.dart';

class CrosswordWidget extends StatefulWidget {
  const CrosswordWidget({super.key});

  @override
  State<CrosswordWidget> createState() => _CrosswordWidgetState();
}

class _CrosswordWidgetState extends State<CrosswordWidget> {
  @override
  Widget build(BuildContext context) {
    final CrosswordEntity crossword = CrosswordEntity.generate;
    return Container(
        margin: EdgeInsets.only(top: Sizer().getHeight(184)),
        width: Sizer().getWidth(327),
        height: Sizer().getWidth(327),
        child: StaticGrid(
          gap: Sizer().getWidth(4),
          columnCount: 10,
          padding: EdgeInsets.all(Sizer().getWidth(4)),
          children: <Widget>[
            for (int i = 0; i < 100; i++)
              _buildCell(crossword: crossword, index: i)
          ],
        ));
  }

  Widget _buildCell({required CrosswordEntity crossword, required int index}) {
    final CellEntity? cell = crossword.getCell(index);
    return cell == null ? const EmptyCellItem() : CellItem(cell: cell);
  }
}
