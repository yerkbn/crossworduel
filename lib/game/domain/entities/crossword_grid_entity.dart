import 'package:crossworduel/game/core/crossword/entity/point_entity.dart';
import 'package:crossworduel/game/core/crossword/entity/span_entity.dart';
import 'package:crossworduel/game/domain/entities/cell_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

class CrosswordGridEntity extends Equatable {
  final List<CellEntity> cells;

  const CrosswordGridEntity({required this.cells});

  factory CrosswordGridEntity.init(List<SpanEntity> spans) {
    final Map<int, CellEntity> uniqueCell = {};
    for (final SpanEntity span in spans) {
      final List<CellEntity> cells = span.getCells;
      for (int i = 0; i < cells.length; i++) {
        uniqueCell[cells[i].getIndex] = cells[i];
      }
    }
    return CrosswordGridEntity(cells: uniqueCell.values.toList());
  }

  // GETTER
  CellEntity? get getCursive =>
      cells.firstWhere((element) => element.isCursive);

  CellEntity? getCell(PointEntity point) =>
      cells.firstWhereOrNull((element) => element.point == point);

  bool get isValidToEdit {
    final CellEntity? cell = getCursive;
    return cell != null && !cell.isValid;
  }

  // SETTERS
  CrosswordGridEntity modifyCell(
      {required CellEntity Function(CellEntity) modify,
      required PointEntity point}) {
    return copyWith(
        cells: cells.map<CellEntity>((CellEntity item) {
      if (item.point == point) {
        return modify(item);
      } else {
        return item;
      }
    }).toList());
  }

  CrosswordGridEntity turnOff() {
    return copyWith(
        cells: cells
            .map((CellEntity cell) => cell.copyWith(isCursive: false))
            .toList());
  }

  CrosswordGridEntity setCursive({required PointEntity point, bool? vert}) {
    final CrosswordGridEntity grid = turnOff();
    for (int i = 0; i < cells.length; i++) {
      if (cells[i].point == point) {
        cells[i] = cells[i].copyWith(isCursive: true);
      }
    }
    return grid.copyWith(cells: cells);
  }

  CrosswordGridEntity setLetter(
      {required String letter, required SpanEntity activeSpan}) {
    final CellEntity? cursive = getCursive;
    if (isValidToEdit && cursive != null) {
      CrosswordGridEntity grid = turnOff();
      grid = grid.modifyCell(
          modify: (CellEntity cell) => cell.copyWith(currentValue: letter),
          point: cursive.point);
      return grid.modifyCell(
          modify: (CellEntity cell) => cell.copyWith(isCursive: true),
          point: activeSpan.getNextPoint(cursive.point));
    }
    return this;
  }

  CrosswordGridEntity deleteLetter({required SpanEntity activeSpan}) {
    final CellEntity? cursive = getCursive;
    if (isValidToEdit && cursive != null) {
      CrosswordGridEntity grid = turnOff();
      grid = grid.modifyCell(
          modify: (CellEntity cell) => cell.copyWith(currentValue: ""),
          point: cursive.point);
      return grid.modifyCell(
          modify: (CellEntity cell) => cell.copyWith(isCursive: true),
          point: activeSpan.getPrevPoint(cursive.point));
    }
    return this;
  }

  //checkIsItCorrect
  CrosswordGridEntity setCorrectSpans() {
    for (int i = 0; i < cells.length; i++) {
      if (spans[i].isActive) {
        spans[i] = spans[i].setCorrect();
        return copyWith();
      }
    }
    return this;
  }

  CrosswordGridEntity copyWith({List<CellEntity>? cells}) {
    return CrosswordGridEntity(cells: cells ?? this.cells);
  }

  @override
  List<Object?> get props => [];
}
