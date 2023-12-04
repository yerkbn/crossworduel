import 'package:crossworduel/features/unauth/domain/entities/me_entity.dart';
import 'package:crossworduel/game/core/agent/agent.dart';
import 'package:crossworduel/game/core/agent/loading_layer/loading_agent.dart';
import 'package:crossworduel/game/core/agent/player_layer/player_agent.dart';
import 'package:crossworduel/game/core/agent/player_state_holder.dart';
import 'package:crossworduel/game/core/instruction/parent_instruction.dart';
import 'package:crossworduel/game/domain/entities/player_entity.dart';
import 'package:flutter/material.dart';

class GameAgent extends ParentAgent {
  final List<ParentAgent> _agents;

  GameAgent({
    required ParentAgentConfig config,
  })  : _agents = ParentAgent.generateAgents(_agentsCreator, config),
        super(config);

  /// This mechanizm is required to ignore some agents
  /// for instance we recieve list of agent names to ignore
  static final Map<String, ParentAgent Function(ParentAgentConfig config)>
      _agentsCreator = {
    'PlayerAgent': (ParentAgentConfig config) => PlayerAgent(config),
    'LoadingAgent': (ParentAgentConfig config) => LoadingAgent(config),
  };

  @override
  Widget build() {
    return Stack(
        children:
            _agents.map((ParentAgent element) => element.build()).toList());
  }

  @override
  void instructionToAction(InstructionData instruction) {
    try {
      for (final ParentAgent element in _agents) {
        element.instructionToAction(instruction);
      }
    } catch (err) {
      print(':::: (game_agent) execution error -> $err');
    }
  }

  /// This static method will be called inside a game agent in lib
  /// to create Specific game Agent for particular game
  factory GameAgent.agentCreator(MeEntity me) {
    /// Any additional parameter will be added here and will be availible in each agent
    final ParentAgentConfig parentConfigurations = ParentAgentConfig(
      playersHolder: PlayerStatesHolder(
        currentPlayer: PlayerEntity.fromMe(me),
      ),
    );
    return GameAgent(
      config: parentConfigurations,
    );
  }

  @override
  Map<String, InstructionData Function(Map objectMap)> get instructions => {
        for (final ParentAgent element in _agents) ...element.instructions,
      };
}
