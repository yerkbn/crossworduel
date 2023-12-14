import 'package:crossworduel/core/extension/map_error_extension.dart';
import 'package:equatable/equatable.dart';

class HintEntity extends Equatable {
  final List<int> indexes;
  final String hint;
  final bool isRow;

  const HintEntity({
    required this.indexes,
    required this.hint,
    required this.isRow,
  });

  factory HintEntity.parseMap(Map objectMap) {
    return HintEntity(
      indexes: List<int>.from(objectMap.getValueSafely("indexes")),
      hint: objectMap.getValueSafely("hint"),
      isRow: objectMap.getValueSafely("isRow"),
    );
  }

  static List<HintEntity> parseList(List items) {
    final List<HintEntity> result = [];
    for (final item in items) {
      result.add(HintEntity.parseMap(item as Map<String, dynamic>));
    }
    return result;
  }

  @override
  List<Object?> get props => [indexes, hint, isRow];
}
