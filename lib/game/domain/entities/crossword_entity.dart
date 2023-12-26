import 'package:crossworduel/core/extension/map_error_extension.dart';
import 'package:crossworduel/game/core/crossword/entity/point_entity.dart';
import 'package:crossworduel/game/core/crossword/entity/span_entity.dart';
import 'package:crossworduel/game/domain/entities/cell_entity.dart';
import 'package:crossworduel/game/domain/entities/crossword_grid_entity.dart';
import 'package:equatable/equatable.dart';

class CrosswordEntity extends Equatable {
  static const int size = 10;
  final CrosswordGridEntity grid;
  final List<SpanEntity> spans;
  final bool vert; // if there 2 active span we differentiate it by vert

  const CrosswordEntity({
    required this.spans,
    required this.grid,
    this.vert = false,
  });

  CrosswordEntity copyWith({
    CrosswordGridEntity? grid,
    List<SpanEntity>? spans,
    bool? vert,
  }) {
    return CrosswordEntity(
      spans: spans ?? this.spans,
      grid: grid ?? this.grid,
      vert: vert ?? this.vert,
    );
  }

  PointEntity indexToPoint(int index) =>
      PointEntity(x: index % size, y: index ~/ size);

  int pointToIndex(PointEntity point) => point.y * 10 + point.x;

  factory CrosswordEntity.parseMap(Map objectMap) {
    final List<SpanEntity> spans =
        SpanEntity.parseList(objectMap.getValueSafely("spans"));
    final CrosswordGridEntity grid = CrosswordGridEntity.init(spans);
    return CrosswordEntity(spans: spans, grid: grid);
  }

  /// GETTER

  List<SpanEntity> getSpansByPoint(PointEntity point) {
    final List<SpanEntity> result = [];
    for (final SpanEntity span in spans) {
      if (span.isPointBelong(point)) result.add(span);
    }
    return result;
  }

  SpanEntity? get getActiveSpan {
    for (final SpanEntity span in spans) {
      for (final CellEntity cell in span.getCells) {
        final CellEntity? tempCell = grid.getCell(cell.point);
        if (tempCell != null && tempCell.isCursive && span.vert == vert) {
          return span;
        }
      }
    }
    return null;
  }

  /// SETTERS

  CrosswordEntity setActiveCell({
    required PointEntity point,
    bool? opVertParam, // we put opposite vert param
  }) {
    final CrosswordEntity crossword = copyWith(grid: grid.turnOff());
    final List<SpanEntity> spans = crossword.getSpansByPoint(point);
    opVertParam ??= vert;
    if (spans.isEmpty) {
      return this;
    } else if (spans.length == 1) {
      return crossword.setCursive(point: point, span: spans.first);
    } else {
      for (final SpanEntity span in spans) {
        if (span.vert != opVertParam) {
          return crossword.setCursive(point: point, span: span);
        }
      }
      return this;
    }
  }

  CrosswordEntity setCursive(
      {required PointEntity point, required SpanEntity span}) {
    return copyWith(
        grid: grid.setCursive(point: point, span: span), vert: span.vert);
  }

  CrosswordEntity setLetter(String letter) {
    final SpanEntity? activeSpan = getActiveSpan;
    if (activeSpan != null) {
      return copyWith(
          grid: grid.setLetter(
        letter: letter,
        activeSpan: activeSpan,
        spans: spans,
      ));
    }
    return this;
  }

  CrosswordEntity deleteLetter() {
    final SpanEntity? activeSpan = getActiveSpan;
    if (activeSpan != null) {
      return copyWith(grid: grid.deleteLetter(activeSpan: activeSpan));
    }
    return this;
  }

  CrosswordEntity nextPrev() {
    if (spans.isNotEmpty) {
      SpanEntity activeSpan = getActiveSpan ?? spans.first;
      for (int i = 0; i < spans.length; i++) {
        if (activeSpan.point == spans[i].point) {
          if (i == spans.length - 1) {
            activeSpan = spans.first;
          } else {
            activeSpan = spans[i + 1];
          }
          break;
        }
      }
      return setActiveCell(
          point: activeSpan.point, opVertParam: !activeSpan.vert);
    }
    return this;
  }

  @override
  List<Object?> get props => [spans];
}
