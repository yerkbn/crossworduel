import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/features/crossword/domain/entities/cell_entity.dart';
import 'package:crossworduel/features/crossword/domain/entities/crossword_entity.dart';
import 'package:crossworduel/features/crossword/domain/entities/span_entity.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword_run/static_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GeneratedCrosswordWidget extends StatefulWidget {
  final List<List<SpanEntity>> spans;
  const GeneratedCrosswordWidget({super.key, required this.spans});

  @override
  State<GeneratedCrosswordWidget> createState() =>
      _GeneratedCrosswordWidgetState();
}

class _GeneratedCrosswordWidgetState extends State<GeneratedCrosswordWidget> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    CrosswordEntity crosswordEntity =
        CrosswordEntity.empty(spans: widget.spans[index]);
    return Column(
      children: [
        _CrosswordGridWidget(crossword: crosswordEntity),
        16.ph,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                setState(() {
                  if (index > 0) {
                    index--;
                  }
                });
              },
            ),
            CustomContainer(
                paddingSize: 8,
                color: theme.backgroundColor3,
                width: 86,
                child: Text(
                  "${index + 1}/${widget.spans.length}",
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
                setState(() {
                  if (index < widget.spans.length - 1) {
                    index++;
                  }
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _CrosswordGridWidget extends StatefulWidget {
  final CrosswordEntity crossword;
  const _CrosswordGridWidget({required this.crossword});

  @override
  State<_CrosswordGridWidget> createState() => __CrosswordGridWidgetState();
}

class __CrosswordGridWidgetState extends State<_CrosswordGridWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 336.w,
        height: 360.w,
        child: StaticGrid(
          gap: 4.w,
          columnCount: 10,
          children: <Widget>[
            for (int i = 0; i < 100; i++)
              _buildCell(crossword: widget.crossword, index: i)
          ],
        ));
  }

  Widget _buildCell({required CrosswordEntity crossword, required int index}) {
    final CellEntity? cell =
        crossword.grid.getCell(crossword.indexToPoint(index));
    return SizedBox(
      width: 30.w,
      height: 30.w,
      child: cell == null ? const _EmptyCellWidget() : _CellWidget(cell: cell),
    );
  }
}

class _CellWidget extends StatelessWidget {
  final CellEntity cell;
  const _CellWidget({required this.cell});

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
      borderRadius: 6.w,
      color: backgroundColor,
      borderColor: borderColor,
      paddingSize: 0,
      child: Center(
        child: Text(cell.value.toUpperCase(),
            style: theme.headline2.copyWith(
              color: textColor,
              fontSize: 14.sp,
            )),
      ),
    );
  }
}

class _EmptyCellWidget extends StatelessWidget {
  const _EmptyCellWidget({super.key});

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
