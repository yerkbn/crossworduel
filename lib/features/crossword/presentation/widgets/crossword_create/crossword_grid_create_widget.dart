import 'package:crossworduel/features/crossword/domain/entities/cell_entity.dart';
import 'package:crossworduel/features/crossword/domain/entities/crossword_entity.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword_create/cell_create_widget.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword_run/static_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CrosswordGridCreateWidget extends StatefulWidget {
  final CrosswordEntity crossword;
  const CrosswordGridCreateWidget({super.key, required this.crossword});

  @override
  State<CrosswordGridCreateWidget> createState() =>
      _CrosswordGridCreateWidgetState();
}

class _CrosswordGridCreateWidgetState extends State<CrosswordGridCreateWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 336.w,
        height: 364.w,
        child: StaticGrid(gap: 4.w, columnCount: 10, children: <Widget>[
          for (int i = 0; i < 100; i++)
            _buildCell(crossword: widget.crossword, index: i)
        ]));
  }

  Widget _buildCell({required CrosswordEntity crossword, required int index}) {
    final CellEntity? cell =
        crossword.grid.getCell(crossword.indexToPoint(index));
    return cell == null
        ? EmptyCellCreateWidget(point: crossword.indexToPoint(index))
        : CellCreateWidget(cell: cell);
  }
}
