import 'package:crossworduel/features/crossword/domain/entities/cell_entity.dart';
import 'package:crossworduel/features/crossword/domain/entities/point_entity.dart';
import 'package:crossworduel/features/crossword/domain/entities/span_entity.dart';
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
            .map((CellEntity cell) =>
                cell.copyWith(isCursive: false, isCurrent: false))
            .toList());
  }

  CrosswordGridEntity setCursive(
      {required PointEntity point, required SpanEntity span}) {
    final List<CellEntity> spanCells = span.getCells;
    CrosswordGridEntity crossword = turnOff();
    for (final CellEntity item in spanCells) {
      if (item.point != point) {
        crossword = crossword.modifyCell(
            modify: (CellEntity cell) => cell.copyWith(isCurrent: true),
            point: item.point);
      }
    }
    return crossword.modifyCell(
        modify: (CellEntity cell) => cell.copyWith(isCursive: true),
        point: point);
  }

  CrosswordGridEntity setLetter(
      {required String letter,
      required SpanEntity activeSpan,
      required List<SpanEntity> spans}) {
    final CellEntity? cursive = getCursive;
    if (cursive != null) {
      if (isValidToEdit) {
        return turnOff()
            .modifyCell(
                modify: (CellEntity cell) =>
                    cell.copyWith(currentValue: letter),
                point: cursive.point)
            .setCursive(
                point: activeSpan.getNextPoint(cursive.point), span: activeSpan)
            .setCorrectSpans(spans: spans);
      } else {
        return turnOff().setCursive(
            point: activeSpan.getNextPoint(cursive.point), span: activeSpan);
      }
    }
    return this;
  }

  CrosswordGridEntity deleteLetter({required SpanEntity activeSpan}) {
    final CellEntity? cursive = getCursive;
    if (isValidToEdit && cursive != null) {
      if (cursive.currentValue == "") {
        return turnOff()
            .modifyCell(
                modify: (CellEntity cell) => cell.copyWith(currentValue: ""),
                point: activeSpan.getPrevPoint(cursive.point))
            .setCursive(
                point: activeSpan.getPrevPoint(cursive.point),
                span: activeSpan);
      } else {
        return turnOff()
            .modifyCell(
                modify: (CellEntity cell) => cell.copyWith(currentValue: ""),
                point: cursive.point)
            .setCursive(
                point: activeSpan.getPrevPoint(cursive.point),
                span: activeSpan);
      }
    }
    return this;
  }

  //checkIsItCorrect
  CrosswordGridEntity setCorrectSpans({required List<SpanEntity> spans}) {
    List<CellEntity> newCells = List<CellEntity>.from(cells);
    for (int i = 0; i < spans.length; i++) {
      if (spans[i].isSpanCorrect(cells)) {
        newCells = spans[i].getValitCells(newCells);
      }
    }
    return copyWith(cells: newCells);
  }

  int correctSpanCnt(List<SpanEntity> spans) {
    int correctSpn = 0;
    for (int i = 0; i < spans.length; i++) {
      if (spans[i].isSpanCorrect(cells)) {
        correctSpn++;
      }
    }
    return correctSpn;
  }

  CrosswordGridEntity copyWith({List<CellEntity>? cells}) {
    return CrosswordGridEntity(cells: cells ?? this.cells);
  }

  @override
  List<Object?> get props => [cells];
}
