import 'package:crossworduel/game/core/agent/agent.dart';
import 'package:crossworduel/game/core/agent/player_layer/ui/players_controller.dart';
import 'package:crossworduel/game/core/instruction/parent_instruction.dart';
import 'package:crossworduel/game/domain/entities/cell_entity.dart';
import 'package:crossworduel/game/domain/entities/crossword_entity.dart';
import 'package:flutter/material.dart';

/// This agent is responsile for players
/// for their movement and so on
class PlayerAgent extends ParentAgent {
  final GlobalKey<PlayersControllerState> _playersController =
      GlobalKey<PlayersControllerState>();

  late CrosswordEntity _crossword;
  bool _isRow = false;

  PlayersControllerState get _state => _playersController.currentState!;

  PlayerAgent(super.config);

  @override
  Widget build() {
    return PlayersController(
        key: _playersController, currentPlayer: currentPlayer);
  }

  CrosswordEntity turnOff() => _crossword.copyWith(
      items: _crossword.items
          .map((CellEntity cell) => cell.copyWith(isCurrent: false))
          .toList());

  List<int> activeRow(int index, CrosswordEntity crossword) {
    //! not check is it next line or not
    final List<int> result = [];
    final int realIndex = crossword.getCellIndex(index);
    int start = realIndex;
    int end = realIndex;
    if (realIndex > -1) {
      while (true) {
        if (start > 0 &&
            crossword.items[start - 1].index + 1 ==
                crossword.items[start].index) {
          start--;
        } else {
          break;
        }
      }
      while (true) {
        if (end < (crossword.items.length - 1) &&
            crossword.items[end + 1].index - 1 == crossword.items[end].index) {
          end++;
        } else {
          break;
        }
      }
      for (int i = start; i <= end; i++) {
        result.add(crossword.items[i].index);
      }
    }

    return result;
  }

  List<int> activeColumn(int index, CrosswordEntity crossword) {
    final List<int> result = [];
    final int realIndex = crossword.getCellIndex(index);
    int start = realIndex;
    int end = realIndex;
    if (realIndex > -1) {
      result.add(index);
      while (true) {
        final int prev = crossword.items[start].index - 10;
        final int prevIndex = crossword.getCellIndex(prev);
        if (prevIndex != -1) {
          result.add(prev);
          start = prevIndex;
        } else {
          break;
        }
      }

      while (true) {
        final int next = crossword.items[end].index + 10;
        final int nextIndex = crossword.getCellIndex(next);
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

  CrosswordEntity currentSequence(int index) {
    CrosswordEntity crossword = turnOff();
    final List<int> rawSequence = activeRow(index, crossword);
    final List<int> columnSequence = activeColumn(index, crossword);
    List<int> sequence = rawSequence;
    if (rawSequence.length == 1 && columnSequence.length > 1) {
      sequence = columnSequence;
      _isRow = false;
    } else if (columnSequence.length == 1 && rawSequence.length > 1) {
      sequence = rawSequence;
      _isRow = true;
    } else if (_isRow) {
      sequence = columnSequence;
      _isRow = false;
    } else {
      sequence = rawSequence;
      _isRow = true;
    }

    if (sequence.isNotEmpty) {
      for (final int i in sequence) {
        crossword = crossword.modifyCell(
            modify: (CellEntity cell) => cell.copyWith(isCurrent: true),
            index: i);
      }
      _crossword = crossword;
    }

    return crossword;
  }

  @override
  void instructionToAction(InstructionData instruction) {
    if (instruction is PlayerFoundInsD) {
      _state.playerJoined(
          instruction.getFirstOponent(currentPlayerId: currentPlayer.id));
    }

    if (instruction is RunningInsD) {
      _state.setLeftSec(instruction.leftSec);
      _crossword = instruction.crossword;
      _state.setCrossword(_crossword);
    }
    if (instruction is LetterTapInsD) {
      currentSequence(instruction.index);
      _state.setCrossword(_crossword);
    }
  }

  @override
  Map<String, InstructionData Function(Map objectMap)> get instructions => {
        // PLAYERS
        PlayerLeaveInsD.insStatus: PlayerLeaveInsD.parseMap,
        PlayerFoundInsD.insStatus: PlayerFoundInsD.parseMap,
        RunningInsD.insStatus: RunningInsD.parseMap,
        LetterTapInsD.insStatus: LetterTapInsD.parseMap,
      };
}
