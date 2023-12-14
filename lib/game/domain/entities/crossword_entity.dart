import 'package:crossworduel/core/extension/map_error_extension.dart';
import 'package:crossworduel/game/domain/entities/cell_entity.dart';
import 'package:crossworduel/game/domain/entities/hint_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

class CrosswordEntity extends Equatable {
  final List<CellEntity> items;
  final List<HintEntity> hints;
  final bool isRow;

  const CrosswordEntity({
    required this.items,
    required this.hints,
    this.isRow = true,
  });

  CrosswordEntity copyWith({List<CellEntity>? items, bool? isRow}) {
    return CrosswordEntity(
        hints: hints, items: items ?? this.items, isRow: isRow ?? this.isRow);
  }

  CellEntity? getCell(int index) {
    return items.firstWhereOrNull((element) => element.index == index);
  }

  factory CrosswordEntity.parseMap(Map objectMap) {
    return CrosswordEntity(
      items: CellEntity.parseList(objectMap.getValueSafely("items")),
      hints: HintEntity.parseList(objectMap.getValueSafely("hints")),
    );
  }

  int getCellIndex(int index) {
    for (int i = 0; i < items.length; i++) {
      if (items[i].index == index) return i;
    }
    return -1;
  }

  HintEntity get getHint {
    for (final HintEntity hint in hints) {
      if (hint.isRow == isRow && hint.indexes.contains(getCursive)) {
        return hint;
      }
    }
    return const HintEntity(indexes: [], hint: "", isRow: false);
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

  List<int> get getActiveSequence =>
      items.where((e) => e.isCurrent).map((e) => e.index).toList()
        ..sort((a, b) => a.compareTo(b));

  int get getCursive => items.firstWhere((e) => e.isCursive).index;

  // logic
  CrosswordEntity turnOff() => copyWith(
      items: items
          .map((CellEntity cell) =>
              cell.copyWith(isCurrent: false, isCursive: false))
          .toList());

  List<int> activeRow(int index) {
    //! not check is it next line or not
    final List<int> result = [];
    final int realIndex = getCellIndex(index);
    int start = realIndex;
    int end = realIndex;
    if (realIndex > -1) {
      while (true) {
        if (start > 0 && items[start - 1].index + 1 == items[start].index) {
          start--;
        } else {
          break;
        }
      }
      while (true) {
        if (end < (items.length - 1) &&
            items[end + 1].index - 1 == items[end].index) {
          end++;
        } else {
          break;
        }
      }
      for (int i = start; i <= end; i++) {
        result.add(items[i].index);
      }
    }

    return result;
  }

  List<int> activeColumn(int index) {
    final List<int> result = [];
    final int realIndex = getCellIndex(index);
    int start = realIndex;
    int end = realIndex;
    if (realIndex > -1) {
      result.add(index);
      while (true) {
        final int prev = items[start].index - 10;
        final int prevIndex = getCellIndex(prev);
        if (prevIndex != -1) {
          result.add(prev);
          start = prevIndex;
        } else {
          break;
        }
      }

      while (true) {
        final int next = items[end].index + 10;
        final int nextIndex = getCellIndex(next);
        if (nextIndex != -1) {
          result.add(next);
          end = nextIndex;
        } else {
          break;
        }
      }
    }

    return result;
  }

  CrosswordEntity currentSequence(int index, {bool? newIsRow}) {
    CrosswordEntity crossword = turnOff();
    final List<int> rawSequence = activeRow(index);
    final List<int> columnSequence = activeColumn(index);
    List<int> sequence = rawSequence;
    bool curentIsRow = isRow;
    if (newIsRow != null) {
      if (newIsRow) {
        sequence = rawSequence;
        curentIsRow = true;
      } else {
        sequence = columnSequence;
        curentIsRow = false;
      }
    } else {
      if (rawSequence.length == 1 && columnSequence.length > 1) {
        sequence = columnSequence;
        curentIsRow = false;
      } else if (columnSequence.length == 1 && rawSequence.length > 1) {
        sequence = rawSequence;
        curentIsRow = true;
      } else if (curentIsRow) {
        sequence = columnSequence;
        curentIsRow = false;
      } else {
        sequence = rawSequence;
        curentIsRow = true;
      }
    }

    if (sequence.isNotEmpty) {
      for (final int i in sequence) {
        crossword = crossword.modifyCell(
          modify: (CellEntity cell) =>
              cell.copyWith(isCurrent: true, isCursive: i == index),
          index: i,
        );
      }
      return crossword.copyWith(isRow: curentIsRow);
    }

    return this;
  }

  bool get isValidToEdit {
    final int realIndex = getCellIndex(getCursive);
    final CellEntity? cursiveCell = getCell(getCursive);
    return realIndex > -1 && cursiveCell != null && !cursiveCell.isValid;
  }

  CrosswordEntity setLetter(String letter) {
    if (isValidToEdit) {
      final List<int> sequence = getActiveSequence;
      if (sequence.contains(getCursive)) {
        int newCursive = getCursive;
        final int sequenceCursiveIndex =
            sequence.indexWhere((e) => e == getCursive);
        if (sequenceCursiveIndex < sequence.length - 1) {
          newCursive = sequence[sequenceCursiveIndex + 1];
        }
        return modifyCell(
                modify: (CellEntity cell) =>
                    cell.copyWith(currentValue: letter, isCursive: false),
                index: getCursive)
            .modifyCell(
                modify: (CellEntity cell) => cell.copyWith(isCursive: true),
                index: newCursive);
      }
    }
    return this;
  }

  CrosswordEntity deleteLetter() {
    if (isValidToEdit) {
      final List<int> sequence = getActiveSequence;
      if (sequence.contains(getCursive)) {
        int newCursive = getCursive;
        final int sequenceCursiveIndex =
            sequence.indexWhere((e) => e == getCursive);
        if (0 < sequenceCursiveIndex) {
          newCursive = sequence[sequenceCursiveIndex - 1];
        }
        return modifyCell(
                modify: (CellEntity cell) =>
                    cell.copyWith(currentValue: "", isCursive: false),
                index: getCursive)
            .modifyCell(
                modify: (CellEntity cell) => cell.copyWith(isCursive: true),
                index: newCursive);
      }
    }
    return this;
  }

  CrosswordEntity checkIsItCorrect() {
    final List<int> sequence = getActiveSequence;
    bool wordIsCorrect = true;
    for (final int index in sequence) {
      final CellEntity? cell = getCell(index);
      if (cell == null || !cell.isCorrect) {
        wordIsCorrect = false;
        break;
      }
    }
    if (wordIsCorrect) {
      CrosswordEntity crossword = copyWith();
      for (final int i in sequence) {
        crossword = crossword.modifyCell(
          modify: (CellEntity cell) => cell.copyWith(isValid: true),
          index: i,
        );
      }
      return crossword;
    }
    return this;
  }

  CrosswordEntity nextPrev() {
    final HintEntity currentHint = getHint;
    int index = hints.indexOf(currentHint);
    print(hints);
    if (index == hints.length - 1) {
      return copyWith(isRow: hints.first.isRow)
          .currentSequence(hints.first.indexes.first);
    } else {
      index += 1;
      return currentSequence(hints[index].indexes.first,
          newIsRow: hints[index].isRow);
    }
  }

  @override
  List<Object?> get props => [items];
}
