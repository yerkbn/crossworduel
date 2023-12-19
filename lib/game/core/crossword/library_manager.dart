import 'dart:convert';

import 'package:crossworduel/game/core/crossword/entity/word_entity.dart';
import 'package:crossworduel/gen/assets.gen.dart';
import 'package:flutter/services.dart';

class LibraryManager {
  final List<WordEntity> words = [];
  final Map<String, List<WordEntity>> wordMap = {};

  Future<void> init({required int size}) async {
    final String response = await rootBundle.loadString(Assets.dict.words);
    final List<Map<String, dynamic>> db =
        List<Map<String, dynamic>>.from(json.decode(response) as Iterable);
    for (final Map<String, dynamic> item in db) {
      final WordEntity word = WordEntity.parseMap(item);
      if (word.length > size) continue;
      words.add(word);
      createPatternHash(word);
    }
  }

  bool isWord(String word) => wordMap[word] != null;

  List<WordEntity> findWords(String pattern) => wordMap[pattern] ?? [];

  void createPatternHash(WordEntity word) {
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
