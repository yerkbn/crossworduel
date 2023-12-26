import 'dart:convert';
import 'dart:math';

import 'package:crossworduel/gen/assets.gen.dart';
import 'package:flutter/services.dart';

class PatternsManager {
  Future<List<List<String>>> get getPattern async {
    final String response = await rootBundle.loadString(Assets.dict.patterns);

    final List<List<List<String>>> patterns1 = [];
    final List<dynamic> arr1 =
        List<dynamic>.from(json.decode(response) as List<dynamic>);

    for (int i = 0; i < arr1.length; i++) {
      final List<dynamic> arr2 = List<dynamic>.from(arr1[i] as List<dynamic>);
      final List<List<String>> patterns2 = [];
      for (int j = 0; j < arr2.length; j++) {
        final List<String> patterns3 = [];
        final List<dynamic> arr3 = List<dynamic>.from(arr2[j] as List<dynamic>);
        for (int k = 0; k < arr3.length; k++) {
          patterns3.add(arr3[k] as String);
        }
        patterns2.add(patterns3);
      }
      patterns1.add(patterns2);
    }

    final Random random = Random();

    return patterns1[random.nextInt(patterns1.length)];
  }
}
