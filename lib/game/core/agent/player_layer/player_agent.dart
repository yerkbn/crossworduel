import 'package:crossworduel/game/core/agent/agent.dart';
import 'package:crossworduel/game/core/agent/player_layer/ui/players_controller.dart';
import 'package:crossworduel/game/core/instruction/parent_instruction.dart';
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
      _state.playerJoined(
          instruction.getFirstOponent(currentPlayerId: currentPlayer.id));
    }

    if (instruction is RunningInsD) {
      _state.setLeftSec(instruction.leftSec);
      _crossword = instruction.crossword;
      _state.setCrossword(_crossword);
    }
    if (instruction is CrosswordTapInsD) {
      _crossword = _crossword.currentSequence(instruction.index);
      _state.setCrossword(_crossword);
    }
    if (instruction is KeyboardTapInsD) {
      _crossword = _crossword.setLetter(instruction.letter);
      _state.setCrossword(_crossword);
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
      };
}
