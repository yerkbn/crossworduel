import 'package:crossworduel/game/core/agent/player_state_holder.dart';
import 'package:crossworduel/game/core/instruction/parent_instruction.dart';
import 'package:crossworduel/game/domain/entities/player_entity.dart';
import 'package:flutter/material.dart';

/// All agents have extend this class
/// and implement methods
abstract class ParentAgent {
  final ParentAgentConfig config;

  /// Access to Players
  PlayerEntity get currentPlayer => config.playersHolder.getCurrentPlayer;
  PlayerEntity? get opponentPlayer => config.playersHolder.getOpponentPlayers;
  PlayerStatesHolder get playersHolder => config.playersHolder;
  bool get isOpponentExist => config.playersHolder.isOpponentExist;

  ParentAgent(this.config);

  Widget build();
  void instructionToAction(InstructionData instruction);

  Map<String, InstructionData Function(Map objectMap)> get instructions;

  /// This function will be used to generate Agents
  /// and will automatically ignore some requested items
  static List<ParentAgent> generateAgents(
    Map<String, ParentAgent Function(ParentAgentConfig config)> agentsCreator,
    ParentAgentConfig config,
  ) {
    final List<ParentAgent> agents = [];
    for (String key in agentsCreator.keys) {
      agents.add(agentsCreator[key]!(config));
    }
    return agents;
  }
}

/// This class is used as ParentValues holder
/// for instance if you want  one value
/// be availible for all agents you have to just
/// add that parameter here and that is it
class ParentAgentConfig {
  final PlayerStatesHolder playersHolder;

  ParentAgentConfig({
    required this.playersHolder,
  });
}
