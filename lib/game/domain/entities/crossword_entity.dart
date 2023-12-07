import 'package:crossworduel/core/extension/map_error_extension.dart';
import 'package:crossworduel/game/domain/entities/cell_entity.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

class CrosswordEntity extends Equatable {
  final List<CellEntity> items;

  const CrosswordEntity({
    required this.items,
  });

  CrosswordEntity copyWith({List<CellEntity>? items}) {
    return CrosswordEntity(
      items: items ?? this.items,
    );
  }

  CellEntity? getCell(int index) {
    return items.firstWhereOrNull((element) => element.index == index);
  }

  factory CrosswordEntity.parseMap(Map objectMap) {
    return CrosswordEntity(
      items: CellEntity.parseList(objectMap.getValueSafely("items")),
    );
  }

  int getCellIndex(int index) {
    for (int i = 0; i < items.length; i++) {
      if (items[i].index == index) return i;
    }
    return -1;
  }

  CrosswordEntity modifyCell({
    required CellEntity Function(CellEntity) modify,
    required int index,
  }) {
    final int realIndex = getCellIndex(index);
    if (realIndex > -1) {
      final CellEntity modified = modify(items[realIndex]);
      return copyWith(
          items: items.map<CellEntity>((CellEntity item) {
        return (item.index == index) ? modified : item;
      }).toList());
    }
    return this;
  }

  @override
  List<Object?> get props => [items];
}
