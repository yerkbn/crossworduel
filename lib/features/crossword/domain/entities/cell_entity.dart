import 'package:crossworduel/core/extension/map_error_extension.dart';
import 'package:crossworduel/features/crossword/domain/entities/point_entity.dart';
import 'package:equatable/equatable.dart';

class CellEntity extends Equatable {
  final PointEntity point;
  final String value;
  final bool isValid; // if word is correct all cell's of word become valid
  final bool isCursive; // currently editing letter
  final bool isCurrent; // selected span cells
  final String currentValue;

  const CellEntity({
    required this.point,
    required this.value,
    this.isValid = false,
    this.isCursive = false,
    this.isCurrent = false,
    this.currentValue = "",
  });

  CellEntity copyWith({
    bool? isValid,
    bool? isCurrent,
    bool? isCursive,
    String? currentValue,
  }) {
    return CellEntity(
      point: point,
      value: value,
      currentValue: currentValue ?? this.currentValue,
      isValid: isValid ?? this.isValid,
      isCursive: isCursive ?? this.isCursive,
      isCurrent: isCurrent ?? this.isCurrent,
    );
  }

  int get getIndex => point.y * 10 + point.x;

  factory CellEntity.parseMap(Map objectMap) {
    return CellEntity(
      point: PointEntity.parseMap(objectMap.getValueSafely("point")),
      value: objectMap.getValueSafely("value"),
    );
  }

  static List<CellEntity> parseList(List items) {
    final List<CellEntity> result = [];
    for (final item in items) {
      result.add(CellEntity.parseMap(item as Map<String, dynamic>));
    }
    return result;
  }

  bool get isCorrect => currentValue.toUpperCase() == value.toUpperCase();

  @override
  List<Object?> get props => [point, value, isValid, currentValue];
}
