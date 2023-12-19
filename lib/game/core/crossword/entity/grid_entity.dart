import 'package:crossworduel/game/core/crossword/entity/point_entity.dart';
import 'package:crossworduel/game/core/crossword/entity/span_entity.dart';
import 'package:crossworduel/game/core/crossword/entity/word_entity.dart';

class GridEntity {
  final int size;
  final List<SpanEntity> spans;
  final List<List<String>> matrix;

  GridEntity({required this.matrix, required this.spans})
      : size = matrix.length;

  void init() {
    fillSpans(vert: false);
    fillSpans(vert: true);
  }

  void fillSpans({required bool vert}) {
    final PointEntity point = PointEntity(x: 0, y: 0);
    while (inBounds(point)) {
      while (inBounds(point) && isBloc(point)) {
        next(vert: vert, point: point);
      }
      if (!inBounds(point)) return;
      final PointEntity startPoint = point.copy();
      int len = 0;
      bool keepGoing = false;
      do {
        keepGoing = nextStopAtWrap(vert: vert, point: point);
        len++;
      } while (keepGoing && !isBloc(point));
      spans.add(SpanEntity(point: startPoint, length: len, vert: vert));
    }
  }

  GridEntity copy() {
    return GridEntity(matrix: [
      ...matrix.map<List<String>>((List<String> col) => List.from(col))
    ], spans: List.from(spans));
  }

  int get getMaxSpanLength {
    int max = 0;
    for (final SpanEntity item in spans) {
      if (item.length > max) {
        max = item.length;
      }
    }
    return max;
  }

  bool inBounds(PointEntity point) {
    return (point.y >= 0 && point.y < size) && (point.x >= 0 && point.x < size);
  }

  bool next({required bool vert, required PointEntity point}) {
    if (vert) {
      point.y++;
      if (point.y >= size) {
        point.y = 0;
        point.x++;
      }
    } else {
      point.x++;
      if (point.x >= size) {
        point.x = 0;
        point.y++;
      }
    }
    return inBounds(point);
  }

  bool nextStopAtWrap({required bool vert, required PointEntity point}) {
    bool wrap = false;
    if (vert) {
      point.y++;
      if (point.y >= size) {
        point.y = 0;
        point.x++;
        wrap = true;
      }
    } else {
      point.x++;
      if (point.x >= size) {
        point.x = 0;
        point.y++;
        wrap = true;
      }
    }
    return !wrap;
  }

  bool isBloc(PointEntity point) {
    if (inBounds(point)) {
      return matrix[point.y][point.x] == WordEntity.block;
    }
    return false;
  }

  String box(PointEntity point) {
    return matrix[point.y][point.x];
  }

  void writeBox({required PointEntity point, required String letter}) {
    assert(inBounds(point));
    matrix[point.y][point.x] = letter;
  }

  String getSpanString({required SpanEntity span, AttrEntity? intitialAttr}) {
    final AttrEntity attr = intitialAttr ?? AttrEntity();
    String result = "";
    for (int i = 0; i < span.length; i++) {
      final String value = box(span.getPoint(i));
      if (value == WordEntity.empty) {
        attr.hasBlanks = true;
      } else if (value != WordEntity.block && value != WordEntity.empty) {
        attr.hasLetters = true;
      }
      result += value;
    }
    return result;
  }

  void setSpanString({required SpanEntity span, required WordEntity word}) {
    assert(span.length == word.length);
    for (int i = 0; i < word.length; i++) {
      writeBox(
          point: span.getPoint(i), letter: word.answer.substring(i, i + 1));
    }
  }

  void printMatrix() {
    final int size = matrix.length;
    for (int i = 0; i < size; i++) {
      String row = "";
      for (int j = 0; j < size; j++) {
        row += matrix[i][j];
      }
      print('$row\n');
    }
  }

  void printSpans() {
    for (int i = 0; i < spans.length; i++) {
      print("${spans[i]} :: ${getSpanString(span: spans[i])}");
    }
  }
}
