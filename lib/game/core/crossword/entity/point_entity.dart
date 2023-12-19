import 'package:crossworduel/core/extension/map_error_extension.dart';

class PointEntity {
  int x;
  int y;

  PointEntity({required this.x, required this.y});

  PointEntity copy() => PointEntity(x: x, y: y);

  factory PointEntity.parseMap(Map objectMap) {
    return PointEntity(
      x: objectMap.getValueSafely("x"),
      y: objectMap.getValueSafely("y"),
    );
  }

  PointEntity operator +(PointEntity other) {
    return PointEntity(x: x + other.x, y: y + other.y);
  }

  @override
  bool operator ==(Object other) =>
      other is PointEntity && x == other.x && y == other.y;

  @override
  String toString() {
    return (x, y).toString();
  }
}

class AttrEntity {
  bool hasLetters;
  bool hasBlanks;

  AttrEntity({this.hasLetters = false, this.hasBlanks = false});

  bool get isEmpty => !hasLetters && hasBlanks;
  bool get isPartial => hasLetters && hasBlanks;
  bool get isFull => hasLetters && !hasBlanks;
}
