import 'package:crossworduel/core/extension/map_error_extension.dart';
import 'package:crossworduel/game/core/crossword/entity/point_entity.dart';
import 'package:crossworduel/game/domain/entities/cell_entity.dart';

class SpanEntity {
  final PointEntity point;
  final int length;
  final bool vert;
  final String answer;
  final String clue;

  SpanEntity({
    required this.point,
    required this.length,
    required this.vert,
    this.answer = "",
    this.clue = "",
  });

  /// GETTERS

  PointEntity getPoint(int index) {
    assert(index >= 0 && index < length);
    if (vert) {
      return PointEntity(x: point.x, y: point.y + index);
    } else {
      return PointEntity(x: point.x + index, y: point.y);
    }
  }

  PointEntity getNextPoint(PointEntity point) {
    for (int i = 0; i < length; i++) {
      if (point == getPoint(i)) {
        if (i == length - 1) {
          return point;
        } else {
          return getPoint(i + 1);
        }
      }
    }
    throw "POINT NOT BELONG TO SPAN";
  }

  PointEntity getPrevPoint(PointEntity point) {
    for (int i = 0; i < length; i++) {
      if (point == getPoint(i)) {
        if (i == 0) {
          return point;
        } else {
          return getPoint(i - 1);
        }
      }
    }
    throw "POINT NOT BELONG TO SPAN";
  }

  bool isPointBelong(PointEntity point) {
    for (int i = 0; i < length; i++) {
      if (point == getPoint(i)) return true;
    }
    return false;
  }

  List<CellEntity> get getCells {
    final List<CellEntity> cells = [];
    for (int i = 0; i < length; i++) {
      final CellEntity cell =
          CellEntity(point: getPoint(i), value: answer.substring(i, i + 1));
      cells.add(cell);
    }
    return cells;
  }

  /// SETTERS

  SpanEntity copyWith({List<CellEntity>? cells}) {
    return SpanEntity(
      point: point,
      length: length,
      vert: vert,
      answer: answer,
      clue: clue,
    );
  }

  // int cellIndexByPoint({
  //   required PointEntity point,
  //   required List<CellEntity> cells,
  // }) {
  //   for (int i = 0; i < cells.length; i++) {
  //     if (cells[i].point == point) {
  //       return i;
  //     }
  //   }
  //   return -1;
  // }

  // int getNextIndex({
  //   required PointEntity point,
  //   required List<CellEntity> cells,
  // }) {
  //   for (int i = 0; i < length; i++) {
  //     final PointEntity nextPoint = getPoint(i);
  //     if (point == nextPoint) {
  //       if (i == length - 1) {
  //         return cellIndexByPoint(cells: cells, point: point);
  //       } else {
  //         return cellIndexByPoint(cells: cells, point: getPoint(i + 1));
  //       }
  //     }
  //   }
  //   return -1;
  // }

  factory SpanEntity.parseMap(Map objectMap) {
    return SpanEntity(
      point: PointEntity.parseMap(objectMap.getValueSafely("point")),
      length: objectMap.getValueSafely("length"),
      vert: objectMap.getValueSafely("vert"),
      answer: objectMap.getValueSafely("answer"),
      clue: objectMap.getValueSafely("clue"),
    );
  }

  static List<SpanEntity> parseList(List items) {
    final List<SpanEntity> result = [];
    for (final item in items) {
      result.add(SpanEntity.parseMap(item as Map<String, dynamic>));
    }
    return result;
  }

  @override
  String toString() {
    return "[$point len=$length vert=$vert]";
  }
}
