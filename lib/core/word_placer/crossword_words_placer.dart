import 'package:crossworduel/features/crossword/domain/entities/point_entity.dart';
import 'package:crossworduel/features/crossword/domain/entities/span_entity.dart';

class CrosswordWordsPlacer {
  static const int maxDepth = 1000;
  static const int columns = 10;
  static const String empty = '-';
  List<List<String>> grid = [];
  int depth = 0;

  List<List<SpanEntity>> solve(List<String> items) {
    depth = 0;
    List<List<SpanEntity>> answers = [];
    _createEmptyGrid();
    List<String> sortedWords = _sortWords(items);
    List<List<String>> allPermutations = _getPermutations(sortedWords);
    print(allPermutations);

    for (List<String> permutation in allPermutations) {
      if (_placeWords(permutation, 0)) {
        _printGrid();
        List<SpanEntity> newSpan = _convertToSpans();
        if (isUnique(answers, newSpan)) answers.add(newSpan);
        _createEmptyGrid();
      }
    }
    return answers;
  }

  bool isUnique(List<List<SpanEntity>> spans, List<SpanEntity> newSpan) {
    for (List<SpanEntity> spanList in spans) {
      if (_areSpansEqual(spanList, newSpan)) {
        return false;
      }
    }
    return true;
  }

  bool _areSpansEqual(List<SpanEntity> spanList1, List<SpanEntity> spanList2) {
    if (spanList1.length != spanList2.length) return false;

    for (int i = 0; i < spanList1.length; i++) {
      if (spanList1[i] != spanList2[i]) {
        return false;
      }
    }

    return true;
  }

  List<SpanEntity> _convertToSpans() {
    List<SpanEntity> spans = [];

    for (int row = 0; row < grid.length; row++) {
      for (int col = 0; col < grid[row].length; col++) {
        if (grid[row][col] != empty) {
          // Check horizontal word
          if (col == 0 || grid[row][col - 1] == empty) {
            String answer = grid[row][col];

            while (col + answer.length < columns &&
                grid[row][col + answer.length] != empty) {
              answer += grid[row][col + answer.length];
            }
            if (answer.length > 1) {
              spans.add(SpanEntity(
                  point: PointEntity(x: col, y: row),
                  length: answer.length,
                  vert: false,
                  answer: answer));
            }
          }

          // Check vertical word
          if (row == 0 || grid[row - 1][col] == empty) {
            String answer = grid[row][col];
            while (row + answer.length < grid.length &&
                grid[row + answer.length][col] != empty) {
              answer += grid[row + answer.length][col];
            }
            if (answer.length > 1) {
              spans.add(SpanEntity(
                  point: PointEntity(x: col, y: row),
                  length: answer.length,
                  vert: true,
                  answer: answer));
            }
          }
        }
      }
    }

    return spans;
  }

  List<List<String>> _getPermutations(List<String> words) {
    if (words.isEmpty) return [[]];
    List<List<String>> permutations = [];
    for (int i = 0; i < words.length; i++) {
      // Remove the current word and get the permutations of the remaining words
      List<String> remainingWords = List.from(words)..removeAt(i);
      List<List<String>> subPermutations = _getPermutations(remainingWords);
      // Add the current word to each permutation
      for (var subPermutation in subPermutations) {
        permutations.add([words[i], ...subPermutation]);
      }
    }
    return permutations;
  }

  List<String> _sortWords(List<String> words) {
    words.sort((a, b) => b.length.compareTo(a.length));
    words = words.map((String i) => i.toUpperCase()).toList();
    return words;
  }

  void _createEmptyGrid() {
    grid = List.generate(
        10, (_) => List.generate(10, (_) => empty, growable: false),
        growable: false);
  }

  bool _placeWords(List<String> words, int wordIndex) {
    if (depth > maxDepth) return false;
    depth++;
    if (wordIndex >= words.length) {
      return true; // All words placed
    }

    String word = words[wordIndex];
    int attempts = columns * columns;
    int length = word.length;
    for (int attempt = 0; attempt < attempts; attempt++) {
      int row = attempt ~/ columns; // Integer division to get the row
      int col = attempt % columns; // Remainder to get the column

      // horizontal
      if ((columns - col) >= length) {
        if (_canPlaceWord(word, row, col, true)) {
          List<List<String>> backupGrid = _copyGrid();
          _placeWord(word, row, col, true);
          // printGrid();
          if (_placeWords(words, wordIndex + 1)) {
            return true;
          } else {
            grid = backupGrid; // Backtrack
          }
        }
      }

      // vertical
      if ((columns - row) >= length) {
        if (_canPlaceWord(word, row, col, false)) {
          List<List<String>> backupGrid = _copyGrid();
          _placeWord(word, row, col, false);
          if (_placeWords(words, wordIndex + 1)) {
            return true;
          } else {
            grid = backupGrid; // Backtrack
          }
        }
      }
    }
    return false; // If no placement was possible
  }

  bool get _isGridEmpty {
    for (int row = 0; row < grid.length; row++) {
      for (int col = 0; col < grid[row].length; col++) {
        if (grid[row][col] != empty) {
          return false; // Found a non-empty cell, grid is not empty
        }
      }
    }
    return true; // All cells are empty
  }

  bool _canPlaceWord(String word, int row, int col, bool horizontal) {
    if (horizontal) {
      if (col + word.length > columns) return false;
      // if there some word before or after
      if (col > 0 && grid[row][col - 1] != empty) return false;
      if (col < (columns - 1) && grid[row][col + 1] != empty) return false;
      // if there same horizontal words with same start or end(to horizontal gridart)
      if (col > 0 && grid[row][col] == word[0] && grid[row][col - 1] != empty)
        return false;
      if (col + word.length < columns &&
          grid[row][col + word.length - 1] == word[word.length - 1] &&
          grid[row][col + word.length] != empty) return false;

      for (int i = 0; i < word.length; i++) {
        // check for taken or not
        if (grid[row][col + i] != empty && grid[row][col + i] != word[i])
          return false;
        // check for overlapping by top
        if (row > 0 &&
            (grid[row - 1][col + i] != empty && grid[row][col + i] == empty))
          return false;

        // check for overlapping by bottom
        if (row < (columns - 1) &&
            (grid[row + 1][col + i] != empty && grid[row][col + i] == empty))
          return false;
      }
      if (!_isGridEmpty) {
        for (int i = 0; i < word.length; i++) {
          if (grid[row][col + i] == word[i])
            return true; // Ensuring there's at least one intersection
        }
      } else {
        return true;
      }
    } else {
      if (row + word.length > 10) return false;
      if (row > 0 && grid[row - 1][col] != empty) return false;
      if (row < (columns - 1) && grid[row + 1][col] != empty) return false;
      // if there same vertical words with same start or end(to vertical gridart)
      if (row > 0 && grid[row][col] == word[0] && grid[row - 1][col] != empty)
        return false;
      if (row + word.length < columns &&
          grid[row + word.length - 1][col] == word[word.length - 1] &&
          grid[row + word.length][col] != empty) return false;
      for (int i = 0; i < word.length; i++) {
        // check for taken or not
        if (grid[row + i][col] != empty && grid[row + i][col] != word[i])
          return false;

        // check for overlapping by left
        if (col > 0 &&
            (grid[row + i][col - 1] != empty && grid[row + i][col] == empty))
          return false;
        // check for overlapping by right
        if (col < (columns - 1) &&
            (grid[row + i][col + 1] != empty && grid[row + i][col] == empty))
          return false;
      }
      if (!_isGridEmpty) {
        for (int i = 0; i < word.length; i++) {
          if (grid[row + i][col] == word[i])
            return true; // Ensuring there's at least one intersection
        }
      } else {
        return true;
      }
    }
    return false; // No valid intersection
  }

  void _placeWord(String word, int row, int col, bool horizontal) {
    if (horizontal) {
      for (int i = 0; i < word.length; i++) {
        grid[row][col + i] = word[i];
      }
    } else {
      for (int i = 0; i < word.length; i++) {
        grid[row + i][col] = word[i];
      }
    }
  }

  List<List<String>> _copyGrid() {
    return grid.map((row) => List<String>.from(row)).toList();
  }

  void _printGrid() {
    for (var row in grid) {
      print(row.join(empty));
    }
    print("");
  }
}
