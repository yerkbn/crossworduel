import 'package:crossworduel/core/extension/map_error_extension.dart';
import 'package:crossworduel/features/crossword/domain/entities/cell_entity.dart';
import 'package:crossworduel/features/crossword/domain/entities/point_entity.dart';
import 'package:equatable/equatable.dart';

class SpanEntity extends Equatable {
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

  bool isSpanCorrect(List<CellEntity> cells) {
    for (final CellEntity cell in cells) {
      if (!cell.isCorrect && isPointBelong(cell.point)) {
        return false;
      }
    }
    return true;
  }

  List<CellEntity> getValitCells(List<CellEntity> cells) {
    for (int i = 0; i < cells.length; i++) {
      if (cells[i].isCorrect && isPointBelong(cells[i].point)) {
        cells[i] = cells[i].copyWith(isValid: true);
      }
    }
    return cells;
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

  List<CellEntity> getCells({bool isCurrentValueFilled = false}) {
    final List<CellEntity> cells = [];
    for (int i = 0; i < length; i++) {
      String answerLetter = answer.substring(i, i + 1);
      final CellEntity cell = CellEntity(
          point: getPoint(i),
          value: answerLetter,
          currentValue: isCurrentValueFilled ? answerLetter : "");
      cells.add(cell);
    }
    return cells;
  }

  @override
  bool operator ==(Object other) =>
      other is SpanEntity &&
      point == other.point &&
      length == other.length &&
      vert == other.vert;

  /// SETTERS

  SpanEntity copyWith({String? answer, String? clue}) {
    return SpanEntity(
      point: point,
      length: length,
      vert: vert,
      answer: answer ?? this.answer,
      clue: clue ?? this.clue,
    );
  }

  factory SpanEntity.parseMap(Map objectMap) {
    return SpanEntity(
      point: PointEntity.parseMap(objectMap.getValueSafely("point")),
      length: objectMap.getValueSafely("length"),
      vert: objectMap.getValueSafely("vert"),
      answer: objectMap.getValueSafely("answer", placeholder: ""),
      clue: objectMap.getValueSafely("clue", placeholder: ""),
    );
  }

  Map<String, dynamic> get toJson => {
        "point": point.toJson,
        "length": length,
        "vert": vert,
        "answer": answer,
        "clue": clue,
      };

  static List<SpanEntity> parseList(List items) {
    final List<SpanEntity> result = [];
    for (final item in items) {
      result.add(SpanEntity.parseMap(item as Map<String, dynamic>));
    }
    return result;
  }

  @override
  String toString() {
    return "[$point len=$length vert=$vert, answer=$answer]";
  }

  @override
  List<Object?> get props => [point, length, vert, answer, clue];
}
