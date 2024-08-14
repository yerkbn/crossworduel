import 'package:crossworduel/core/extension/map_error_extension.dart';
import 'package:crossworduel/core/normalizer/normalizer.dart';
import 'package:crossworduel/features/crossword/domain/entities/cell_entity.dart';
import 'package:crossworduel/features/crossword/domain/entities/crossword_grid_entity.dart';
import 'package:crossworduel/features/crossword/domain/entities/point_entity.dart';
import 'package:crossworduel/features/crossword/domain/entities/span_entity.dart';
import 'package:crossworduel/features/profile/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

class CrosswordEntity extends Equatable with Normalizer {
  static const int SIZE = 10;
  static const String EMPTY = " ";

  final String id;
  final String created_at;
  final String title;
  final String description;
  final String language;
  final String difficulty;
  final UserEntity user;
  final double star;

  // logic
  final List<SpanEntity> spans;
  final CrosswordGridEntity grid;
  final bool vert;

  const CrosswordEntity({
    required this.id,
    required this.created_at,
    required this.user,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.language,
    required this.star,
    required this.spans,
    required this.grid,
    this.vert = false,
  });

  factory CrosswordEntity.fromJson(Map<String, dynamic> json) {
    List<SpanEntity> spans = SpanEntity.parseList(json.getValueSafely("spans"));
    return CrosswordEntity(
      id: json.getValueSafely("id"),
      created_at: json.getValueSafely("created_at"),
      user: UserEntity.fromJson(json.getValueSafely("user")),
      title: json.getValueSafely("title"),
      description: json.getValueSafely("description"),
      difficulty: json.getValueSafely("difficulty"),
      language: json.getValueSafely("language"),
      star: json.getValueSafely<num>("star").toDouble(),
      spans: spans,
      grid: CrosswordGridEntity.init(spans),
    );
  }

  factory CrosswordEntity.empty({List<SpanEntity>? spans}) {
    return CrosswordEntity(
        description: "",
        created_at: "",
        difficulty: "",
        language: "",
        title: "",
        id: "",
        star: 0,
        spans: spans ?? [],
        user: UserEntity.empty(),
        grid: CrosswordGridEntity.init(spans ?? []));
  }

  static List<CrosswordEntity> parseList(List items) {
    final List<CrosswordEntity> result = [];
    for (final item in items) {
      result.add(CrosswordEntity.fromJson(item as Map<String, dynamic>));
    }
    return result;
  }

  Map<String, dynamic> toJson() => {
        "description": description,
        "difficulty": difficulty,
        "created_at": created_at,
        "language": language,
        "user_id": user.id,
        "title": title,
        "id": id,
      };

  PointEntity indexToPoint(int index) =>
      PointEntity(x: index % SIZE, y: index ~/ SIZE);

  // logic

  CrosswordEntity nextPrev({required bool isNext}) {
    if (spans.isNotEmpty) {
      SpanEntity activeSpan = getActiveSpan ?? spans.first;
      for (int i = 0; i < spans.length; i++) {
        if (activeSpan.point == spans[i].point &&
            activeSpan.vert == spans[i].vert) {
          if (isNext) {
            if (i == spans.length - 1) {
              activeSpan = spans.first;
            } else {
              activeSpan = spans[i + 1];
            }
          } else {
            if (i == 0) {
              activeSpan = spans.last;
            } else {
              activeSpan = spans[i - 1];
            }
          }

          break;
        }
      }
      return setActiveCell(
          point: activeSpan.point, opVertParam: !activeSpan.vert);
    }
    return this;
  }

  SpanEntity? get getActiveSpan {
    for (final SpanEntity span in spans) {
      for (final CellEntity cell in span.getCells()) {
        final CellEntity? tempCell = grid.getCell(cell.point);
        if (tempCell != null && tempCell.isCursive && span.vert == vert) {
          return span;
        }
      }
    }
    return null;
  }

  CrosswordEntity setLetter(String letter) {
    final SpanEntity? activeSpan = getActiveSpan;
    if (activeSpan != null) {
      return copyWith(
          grid: grid.setLetter(
              letter: letter, activeSpan: activeSpan, spans: spans));
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

  /// Check does given point has words in prev point
  PointEntity hasPrevPoint(PointEntity point, bool vert) {
    PointEntity prevPoint = point;
    while (true) {
      if (vert) {
        if (prevPoint.y == 0) break;
        prevPoint = prevPoint.copyWith(y: prevPoint.y - 1);
      } else {
        if (prevPoint.x == 0) break;
        prevPoint = prevPoint.copyWith(x: prevPoint.x - 1);
      }
      CellEntity? cell = grid.getCell(prevPoint);
      if (cell == null || grid.getCell(prevPoint)!.currentValue == "") {
        return point;
      } else {
        point = prevPoint;
      }
    }
    return prevPoint;
  }

  void deleteOnlySpan(PointEntity point, bool vert) {
    for (SpanEntity span in spans) {
      if (span.point == point && span.vert == vert) {
        spans.remove(span);
        return;
      }
    }
  }

  CrosswordEntity createTempSpan(
      {required PointEntity point, SpanEntity? activeSpan}) {
    CrosswordEntity newCrossword = copyWith();
    PointEntity spanStartPoint = point;
    if (activeSpan != null && activeSpan.point == point) {
      newCrossword = newCrossword.copyWith(vert: !activeSpan.vert);
    }
    spanStartPoint = hasPrevPoint(spanStartPoint, newCrossword.vert);
    deleteOnlySpan(spanStartPoint, newCrossword.vert);
    int length = SIZE - (newCrossword.vert ? point.y : point.x);
    // TODO check for validity is above this point some letter or not

    SpanEntity span = SpanEntity(
        point: spanStartPoint,
        length: length,
        vert: newCrossword.vert,
        answer: emptyStringLength(length));

    // check for validity
    CrosswordGridEntity newGrid = grid.createSpan(span: span);
    newGrid = newGrid.setCursive(point: point, span: span);
    return newCrossword
        .copyWith(spans: [...spans, span], grid: newGrid, vert: span.vert);
  }

  /// This function delete all empty spans
  /// Create spans if exists
  CrosswordEntity normalizeSpans() {
    final List<SpanEntity> newSpans = [];
    for (int i = 0; i < spans.length; i++) {
      if (spans[i].answer.contains(EMPTY)) {
        List<CellEntity> cells = grid.getCells(spans[i]);
        String answer = "";
        PointEntity? initialPoint;
        for (CellEntity cell in cells) {
          if (cell.currentValue != EMPTY && cell.currentValue.length > 0) {
            if (initialPoint != null) {
              answer += cell.currentValue;
            } else {
              initialPoint = cell.point;
              answer = cell.currentValue;
            }
          } else {
            if (initialPoint != null) {
              if (answer.length > 1) {
                SpanEntity newSpan = SpanEntity(
                    point: initialPoint,
                    length: answer.length,
                    answer: answer,
                    clue: "WHAT IS?",
                    vert: spans[i].vert);
                newSpans.add(newSpan);
              }
              answer = "";
              initialPoint = null;
            }
          }
        }
      } else {
        newSpans.add(spans[i]);
      }
    }

    CrosswordGridEntity newGrid =
        CrosswordGridEntity.init(newSpans, isCurrentValueFilled: true);
    print("SPANS CNT ${newSpans.length}");
    for (SpanEntity span in spans) {
      print("SPAN = ${span}");
    }
    return copyWith(grid: newGrid, spans: newSpans);
  }

  String emptyStringLength(int length) {
    String result = "";
    for (int i = 0; i < length; i++) result += EMPTY;
    return result;
  }

  CrosswordEntity setCursive(
      {required PointEntity point, required SpanEntity span}) {
    return copyWith(
        grid: grid.setCursive(point: point, span: span), vert: span.vert);
  }

  List<SpanEntity> getSpansByPoint(PointEntity point) {
    final List<SpanEntity> result = [];
    for (final SpanEntity span in spans) {
      if (span.isPointBelong(point)) result.add(span);
    }
    return result;
  }

  CrosswordEntity copyWith({
    CrosswordGridEntity? grid,
    List<SpanEntity>? spans,
    bool? vert,
  }) {
    return CrosswordEntity(
      spans: spans ?? this.spans,
      grid: grid ?? this.grid,
      vert: vert ?? this.vert,
      created_at: created_at,
      description: description,
      difficulty: difficulty,
      language: language,
      title: title,
      star: star,
      user: user,
      id: id,
    );
  }

  // getters
  int get getCorrectSpnCnt => grid.correctSpanCnt(spans);
  bool get isAllAnswered => getCorrectSpnCnt == spans.length;
  String get getRating => normalizeString(star.toString(), maxLength: 3);

  @override
  List<Object?> get props => [
        id,
        created_at,
        user,
        title,
        description,
        language,
        difficulty,
        grid,
        vert,
        spans
      ];
}
