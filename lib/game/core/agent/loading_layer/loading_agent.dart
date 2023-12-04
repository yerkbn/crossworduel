import 'package:crossworduel/game/core/agent/agent.dart';
import 'package:crossworduel/game/core/agent/loading_layer/ui/loading_controller.dart';
import 'package:crossworduel/game/core/instruction/parent_instruction.dart';
import 'package:flutter/material.dart';

/// This agent is responsile for players
/// for their movement and so on
class LoadingAgent extends ParentAgent {
  final GlobalKey<LoadingControllerState> _loadingController =
      GlobalKey<LoadingControllerState>();

  LoadingControllerState get _state => _loadingController.currentState!;

  LoadingAgent(
    super.config,
  );

  @override
  Widget build() {
    return LoadingController(
      key: _loadingController,
      me: currentPlayer,
    );
  }

  @override
  void instructionToAction(InstructionData instruction) {
    if (instruction is RoomCreatedInsD) {
      _state.loadingStart();
    }
  }

  @override
  Map<String, InstructionData Function(Map objectMap)> get instructions => {};
}
