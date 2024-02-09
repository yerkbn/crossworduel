import 'package:crossworduel/game/domain/entities/player_entity.dart';
import 'package:crossworduel/game/game-core/agent/agent.dart';
import 'package:crossworduel/game/game-core/agent/player_layer/ui/players_controller.dart';
import 'package:crossworduel/game/game-core/instruction/parent_instruction.dart';
import 'package:crossworduel/game/domain/entities/crossword_entity.dart';
import 'package:flutter/material.dart';

/// This agent is responsile for players
/// for their movement and so on
class PlayerAgent extends ParentAgent {
  final GlobalKey<PlayersControllerState> _playersController =
      GlobalKey<PlayersControllerState>();

  late CrosswordEntity _crossword;

  PlayersControllerState get _state => _playersController.currentState!;

  PlayerAgent(super.config);

  @override
  Widget build() {
    return PlayersController(
        key: _playersController, currentPlayer: currentPlayer);
  }

  @override
  void instructionToAction(InstructionData instruction) {
    if (instruction is PlayerFoundInsD) {
      for (final PlayerEntity player in instruction.players!) {
        _state.playerUpdate(player);
      }
    }
    if (instruction is RunningInsD) {
      _state.setLeftSec(instruction.leftSec);
      _crossword = instruction.crossword;
      _crossword.printSpans();
      if (_crossword.spans.isNotEmpty) {
        _crossword =
            _crossword.setActiveCell(point: _crossword.spans.first.point);
      }
      _state.setCrossword(_crossword);
    }
    if (instruction is CrosswordTapInsD) {
      _crossword = _crossword.setActiveCell(point: instruction.point);
      _state.setCrossword(_crossword);
    }
    if (instruction is KeyboardTapInsD) {
      _crossword = _crossword.setLetter(instruction.letter);
      _state.setCrossword(_crossword);
    }
    if (instruction is DeleteTapInsD) {
      _crossword = _crossword.deleteLetter();
      _state.setCrossword(_crossword);
    }
    if (instruction is NextPrevInsD) {
      _crossword = _crossword.nextPrev(isNext: instruction.isNext);
      _state.setCrossword(_crossword);
    }
    if (instruction is MoveInsD) {
      _state.playerUpdate(instruction.playerEntity!);
      Future.delayed(const Duration(milliseconds: 50), () {
        _state.lightUp(
            id: instruction.playerEntity!.id, span: instruction.span);
      });
    }
    if (instruction is FinalInsD) {
      _state.setFinal(instruction.finalEntity);
    }
  }

  @override
  Map<String, InstructionData Function(Map objectMap)> get instructions => {
        // PLAYERS
        PlayerLeaveInsD.insStatus: PlayerLeaveInsD.parseMap,
        PlayerFoundInsD.insStatus: PlayerFoundInsD.parseMap,
        RunningInsD.insStatus: RunningInsD.parseMap,
        CrosswordTapInsD.insStatus: CrosswordTapInsD.parseMap,
        KeyboardTapInsD.insStatus: KeyboardTapInsD.parseMap,
        DeleteTapInsD.insStatus: DeleteTapInsD.parseMap,
        NextPrevInsD.insStatus: NextPrevInsD.parseMap,
        FinalInsD.insStatus: FinalInsD.parseMap,
        MoveInsD.insStatus: MoveInsD.parseMap,
      };
}
