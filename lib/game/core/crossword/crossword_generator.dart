import 'dart:convert';

import 'package:crossworduel/core/extension/map_error_extension.dart';
import 'package:crossworduel/game/core/crossword/patterns.dart';
import 'package:crossworduel/gen/assets.gen.dart';
import 'package:flutter/services.dart';

// {
//             "point": {"x": 0, "y": 0},
//             "vert": true,
//             "length": 4,
//             "answer": "COME",
//             "clue": "James Cameron movie",
//           },
// print("SIZE = ${words.length}");
// print("SEARCH = ${words.findWord("D--")}");
class CrosswordGenerator {
  static Future<Map<String, dynamic>> crosswordGenerate(
      {int leftSec = 300}) async {
    final Grid grid = Grid(matrix: size10Bloc44(), spans: []);
    grid.init();
    final Library lib = Library();
    await lib.load(size: grid.getMaxSpanLength);
    final CrosswordSolver solver = CrosswordSolver(grid: grid, lib: lib);
    solver.solve();
    return {};
  }
}

class CrosswordSolver {
  static const maxCount = 10000000;
  static const countStep = maxCount / 100;
  static const maxAnsCount = 20;
  final List<Grid> ansList = [];
  final Grid grid;
  final Library lib;
  int count = 0;
  int ansCount = 0;
  CrosswordSolver({required this.grid, required this.lib});

  void solve() {
    grid.printMatrix();
    _loop(grid: grid.copy(), depth: 0);
  }

  void _loop({required Grid grid, required int depth}) {
    count++;
    depth++;
    if (count % countStep == 0) print("PROGRESS: ${count ~/ countStep}%");
    if (ansCount > maxAnsCount) return;
    if (count > maxCount) return;

    final List<Slot> emptySlots = [];
    final List<Slot> partialSlots = [];
    final List<Slot> fullSlots = [];
    for (final Span span in grid.spans) {
      final Attr attr = Attr();
      final String pattern = grid.getSpanString(span: span, intitialAttr: attr);
      final Slot slot = Slot(span: span, pattern: pattern);
      if (attr.isEmpty) {
        emptySlots.add(slot);
      } else if (attr.isPartial) {
        partialSlots.add(slot);
      } else if (attr.isFull) {
        fullSlots.add(slot);
      }
    }

    // remove incorrect words
    for (final Slot item in fullSlots) {
      if (!lib.isWord(item.pattern)) {
        return;
      }
    }

    // remove duplicate words
    final Set<String> uniqueWords = {};
    for (final Slot item in fullSlots) {
      if (!uniqueWords.add(item.pattern)) {
        return;
      }
    }

    if (partialSlots.isEmpty && emptySlots.isEmpty) {
      print("");
      print("ANSWER = $ansCount");
      ansCount++;
      grid.printMatrix();
      ansList.add(grid);
      return;
    }

    late final Slot goSlot;
    if (partialSlots.isEmpty) {
      goSlot = emptySlots.first;
    } else {
      goSlot = partialSlots.first;
    }
    final List<Word> words = lib.findWords(goSlot.pattern);
    if (words.isNotEmpty) {
      for (final Word item in words) {
        grid.setSpanString(span: goSlot.span, word: item);
        _loop(grid: grid.copy(), depth: depth);
      }
    }
  }
}

class Grid {
  final int size;
  final List<Span> spans;
  final List<List<String>> matrix;

  Grid({required this.matrix, required this.spans}) : size = matrix.length;

  void init() {
    fillSpans(vert: false);
    fillSpans(vert: true);
  }

  void fillSpans({required bool vert}) {
    final Point point = Point(x: 0, y: 0);
    while (inBounds(point)) {
      while (inBounds(point) && isBloc(point)) {
        next(vert: vert, point: point);
      }
      if (!inBounds(point)) return;
      final Point startPoint = point.copy();
      int len = 0;
      bool keepGoing = false;
      do {
        keepGoing = nextStopAtWrap(vert: vert, point: point);
        len++;
      } while (keepGoing && !isBloc(point));
      spans.add(Span(point: startPoint, length: len, vert: vert));
    }
  }

  Grid copy() {
    return Grid(matrix: [
      ...matrix.map<List<String>>((List<String> col) => List.from(col))
    ], spans: List.from(spans));
  }

  int get getMaxSpanLength {
    int max = 0;
    for (final Span item in spans) {
      if (item.length > max) {
        max = item.length;
      }
    }
    return max;
  }

  bool inBounds(Point point) {
    return (point.y >= 0 && point.y < size) && (point.x >= 0 && point.x < size);
  }

  bool next({required bool vert, required Point point}) {
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

  bool nextStopAtWrap({required bool vert, required Point point}) {
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

  bool isBloc(Point point) {
    if (inBounds(point)) {
      return matrix[point.y][point.x] == Word.block;
    }
    return false;
  }

  String box(Point point) {
    return matrix[point.y][point.x];
  }

  void writeBox({required Point point, required String letter}) {
    assert(inBounds(point));
    matrix[point.y][point.x] = letter;
  }

  String getSpanString({required Span span, Attr? intitialAttr}) {
    final Attr attr = intitialAttr ?? Attr();
    String result = "";
    for (int i = 0; i < span.length; i++) {
      final String value = box(span.getPoint(i));
      if (value == Word.empty) {
        attr.hasBlanks = true;
      } else if (value != Word.block && value != Word.empty) {
        attr.hasLetters = true;
      }
      result += value;
    }
    return result;
  }

  void setSpanString({required Span span, required Word word}) {
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

// words list
class Library {
  final List<Word> words = [];
  final Map<String, List<Word>> wordMap = {};

  Future<void> load({required int size}) async {
    final String response = await rootBundle.loadString(Assets.dict.words);
    final List<Map<String, dynamic>> db =
        List<Map<String, dynamic>>.from(json.decode(response) as Iterable);
    for (final Map<String, dynamic> item in db) {
      final Word word = Word.parseMap(item);
      if (word.length > size) continue;
      words.add(word);
      createPatternHash(word);
    }
  }

  bool isWord(String word) => wordMap[word] != null;

  List<Word> findWords(String pattern) => wordMap[pattern] ?? [];

  void createPatternHash(Word word) {
    final int len = word.length;
    final int numPatterns = 1 << len;
    for (int i = 0; i < numPatterns; i++) {
      String temp = word.answer;
      for (int j = 0; j < len; j++) {
        if ((i >> j) & 1 == 1) {
          temp = temp.replaceRange(j, j + 1, "-");
        }
      }
      if (wordMap[temp] == null) {
        wordMap[temp] = [];
      }
      wordMap[temp]!.add(word);
    }
  }

  int get length => words.length;
}

// Word model
class Word {
  static const String empty = "-";
  static const String block = ".";
  final String answer;
  final String clue;

  Word({required this.answer, required this.clue});

  factory Word.parseMap(Map<String, dynamic> obj) {
    return Word(
      answer: obj.getValueSafely<String>("answer").toUpperCase(),
      clue: obj.getValueSafely("clue"),
    );
  }

  int get length => answer.length;

  @override
  String toString() {
    return "$answer - $clue";
  }
}

class Attr {
  bool hasLetters;
  bool hasBlanks;

  Attr({this.hasLetters = false, this.hasBlanks = false});

  bool get isEmpty => !hasLetters && hasBlanks;
  bool get isPartial => hasLetters && hasBlanks;
  bool get isFull => hasLetters && !hasBlanks;
}

// Point

class Point {
  int x;
  int y;

  Point({required this.x, required this.y});

  Point copy() => Point(x: x, y: y);

  @override
  String toString() {
    return (x, y).toString();
  }
}

class Span {
  final Point point;
  final int length;
  final bool vert;

  Span({
    required this.point,
    required this.length,
    required this.vert,
  });

  Point getPoint(int index) {
    assert(index >= 0 && index < length);
    if (vert) {
      return Point(x: point.x, y: point.y + index);
    } else {
      return Point(x: point.x + index, y: point.y);
    }
  }

  @override
  String toString() {
    return "[$point len=$length vert=$vert]";
  }
}

class Slot {
  final Span span;
  final String pattern;

  Slot({required this.span, required this.pattern});

  @override
  String toString() {
    return "$span - $pattern";
  }
}
