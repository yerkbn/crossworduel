import 'package:crossworduel/game/core/crossword/entity/span_entity.dart';

class SlotEntity {
  final SpanEntity span;
  final String pattern;

  SlotEntity({required this.span, required this.pattern});

  @override
  String toString() {
    return "$span - $pattern";
  }
}
