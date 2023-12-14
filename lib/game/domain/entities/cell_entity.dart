import 'package:crossworduel/core/extension/map_error_extension.dart';
import 'package:equatable/equatable.dart';

class CellEntity extends Equatable {
  final int index;
  final String value;
  final bool isValid;
  final bool isCurrent;
  final bool isCursive;
  final String currentValue;

  const CellEntity({
    required this.index,
    required this.value,
    this.isValid = false,
    this.isCurrent = false,
    this.isCursive = false,
    this.currentValue = "",
  });

  CellEntity copyWith({
    bool? isValid,
    bool? isCurrent,
    bool? isCursive,
    String? currentValue,
  }) {
    return CellEntity(
      index: index,
      value: value,
      currentValue: currentValue ?? this.currentValue,
      isValid: isValid ?? this.isValid,
      isCurrent: isCurrent ?? this.isCurrent,
      isCursive: isCursive ?? this.isCursive,
    );
  }

  factory CellEntity.parseMap(Map objectMap) {
    return CellEntity(
      index: objectMap.getValueSafely("index"),
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
  List<Object?> get props => [index, value, isValid, isCurrent];
}
