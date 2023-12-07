import 'package:crossworduel/core/extension/map_error_extension.dart';
import 'package:equatable/equatable.dart';

class CellEntity extends Equatable {
  final int index;
  final String value;
  final bool isHide;
  final bool isCurrent;

  const CellEntity({
    required this.index,
    required this.value,
    this.isHide = false,
    this.isCurrent = false,
  });

  CellEntity copyWith({bool? isHide, bool? isCurrent}) {
    return CellEntity(
        index: index,
        value: value,
        isHide: isHide ?? this.isHide,
        isCurrent: isCurrent ?? this.isCurrent);
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

  @override
  List<Object?> get props => [index, value, isHide, isCurrent];
}
