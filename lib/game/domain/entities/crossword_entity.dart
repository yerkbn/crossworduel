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

  // ignore: prefer_constructors_over_static_methods
  static CrosswordEntity get generate {
    List<CellEntity> sample = [
      const CellEntity(index: 0, value: "A"),
      const CellEntity(index: 1, value: "V"),
      const CellEntity(index: 2, value: "A"),
      const CellEntity(index: 3, value: "T"),
      const CellEntity(index: 4, value: "A"),
      const CellEntity(index: 5, value: "R"),
      const CellEntity(index: 15, value: "A"),
      const CellEntity(index: 16, value: "P"),
      const CellEntity(index: 17, value: "P"),
      const CellEntity(index: 18, value: "L"),
      const CellEntity(index: 19, value: "E"),
    ];
    return CrosswordEntity(items: sample);
  }

  CellEntity? getCell(int index) {
    return items.firstWhereOrNull((element) => element.index == index);
  }

  @override
  List<Object?> get props => [items];
}
