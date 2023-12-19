import 'package:crossworduel/core/extension/map_error_extension.dart';

class WordEntity {
  static const String empty = "-";
  static const String block = ".";
  final String answer;
  final String clue;

  WordEntity({required this.answer, required this.clue});

  factory WordEntity.parseMap(Map<String, dynamic> obj) {
    return WordEntity(
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
