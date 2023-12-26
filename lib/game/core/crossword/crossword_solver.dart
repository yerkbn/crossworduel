import 'dart:convert';
import 'dart:io';

import 'package:crossworduel/game/core/crossword/entity/grid_entity.dart';
import 'package:crossworduel/game/core/crossword/entity/point_entity.dart';
import 'package:crossworduel/game/core/crossword/entity/slot_entity.dart';
import 'package:crossworduel/game/core/crossword/entity/span_entity.dart';
import 'package:crossworduel/game/core/crossword/entity/word_entity.dart';
import 'package:crossworduel/game/core/crossword/library_manager.dart';

class CrosswordSolver {
  static const maxCount = 100000000;
  static const countStep = maxCount / 100;
  static const maxAnsCount = 4;
  final List<GridEntity> ansList = [];
  final GridEntity grid;
  final LibraryManager lib;
  int count = 0;
  int ansCount = 0;
  CrosswordSolver({required this.grid, required this.lib});

  List<Map<String, dynamic>> solve() {
    grid.printMatrix();
    _loop(grid: grid.copy(), depth: 0);
    if (ansList.isEmpty) {
      print("FINALLY I AM NOT HAPPY");
      return [];
    } else {
      final List<List<Map<String, dynamic>>> result =
          ansList.map((GridEntity g) => gridToJson(g)).toList();
      final File file = File(
          "/Users/yerkbn/Documents/projects/crossworduel/crossworduel/assets/dict/crosswords.json");
      file.writeAsStringSync(json.encode(result));
      print("FINALLY I AM HAPPY: ${result.length}");
      return result.first;
    }
  }

  List<Map<String, dynamic>> gridToJson(GridEntity finalGrid) {
    for (int i = 0; i < finalGrid.spans.length; i++) {
      final String wordText = finalGrid.getSpanString(span: finalGrid.spans[i]);
      final WordEntity word = lib.findWords(wordText).first;
      finalGrid.spans[i] = finalGrid.spans[i].copyWith(
        answer: word.answer,
        clue: word.clue,
      );
    }
    return finalGrid.getSpansJSON;
  }

  void _loop({required GridEntity grid, required int depth}) {
    if (count % countStep == 0) print("PROGRESS: ${count ~/ countStep}%");
    count++;
    depth++;
    if (ansCount > maxAnsCount) return;
    if (count > maxCount) return;

    final List<SlotEntity> emptySlots = [];
    final List<SlotEntity> partialSlots = [];
    final List<SlotEntity> fullSlots = [];

    for (final SpanEntity span in grid.spans) {
      final AttrEntity attr = AttrEntity();
      final String pattern = grid.getSpanString(span: span, intitialAttr: attr);
      // print("PATTERN -- $pattern - $span");
      final SlotEntity slot = SlotEntity(span: span, pattern: pattern);
      if (attr.isEmpty) {
        emptySlots.add(slot);
      } else if (attr.isPartial) {
        partialSlots.add(slot);
      } else if (attr.isFull) {
        fullSlots.add(slot);
      }
    }

    // remove incorrect words
    for (final SlotEntity item in fullSlots) {
      if (!lib.isWord(item.pattern)) {
        return;
      }
    }

    // remove duplicate words
    final Set<String> uniqueWords = {};
    for (final SlotEntity item in fullSlots) {
      if (!uniqueWords.add(item.pattern)) {
        return;
      }
    }
    if (partialSlots.isEmpty && emptySlots.isEmpty) {
      if (!isSimilar(grid)) {
        print("");
        print("NEW ANSWER = $ansCount");
        ansCount++;
        grid.printMatrix();
        ansList.add(grid);
      }

      return;
    }

    late final SlotEntity goSlot;
    if (partialSlots.isEmpty) {
      goSlot = emptySlots.first;
    } else {
      goSlot = partialSlots.first;
    }
    final List<WordEntity> words = lib.findWords(goSlot.pattern);
    if (words.isNotEmpty) {
      for (final WordEntity item in words) {
        grid.setSpanString(span: goSlot.span, word: item);
        _loop(grid: grid.copy(), depth: depth);
      }
    }
  }

  bool isSimilar(GridEntity grid) {
    final int size = grid.spans.length;
    final int minDelta = (size * .4).toInt();
    for (final GridEntity item in ansList) {
      if (item.countSimilarWords(grid) > minDelta) {
        return true;
      }
    }
    return false;
  }
}
