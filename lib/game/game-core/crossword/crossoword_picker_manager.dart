import 'dart:convert';
import 'dart:math';

import 'package:crossworduel/gen/assets.gen.dart';
import 'package:flutter/services.dart';

class CrosswordPickerManager {
  final Random random = Random();
  late List<List<Map<String, dynamic>>> crosswords;

  CrosswordPickerManager._create();

  static Future<CrosswordPickerManager> create() async {
    final CrosswordPickerManager picker = CrosswordPickerManager._create();
    await picker._init();
    return picker;
  }

  Future<void> _init() async {
    final String response = await rootBundle.loadString(Assets.dict.crosswords);

    final List<List<Map<String, dynamic>>> db = [];
    final List<dynamic> arr1 =
        List<dynamic>.from(json.decode(response) as List<dynamic>);

    for (int i = 0; i < arr1.length; i++) {
      final List<dynamic> arr2 = List<dynamic>.from(arr1[i] as List<dynamic>);
      final List<Map<String, dynamic>> patterns2 = [];
      for (int j = 0; j < arr2.length; j++) {
        final Map<String, dynamic> map3 =
            Map<String, dynamic>.from(arr2[j] as Map<String, dynamic>);
        patterns2.add(map3);
      }
      db.add(patterns2);
    }
    crosswords = db;
  }

  List<Map<String, dynamic>> pick() {
    print("PATTERNS CNT: ${crosswords.length}");
    return crosswords[random.nextInt(crosswords.length)];
  }
}
