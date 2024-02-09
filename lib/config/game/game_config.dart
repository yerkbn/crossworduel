import 'package:crossworduel/features/profile/domain/entities/user_entity.dart';
import 'package:crossworduel/game/game-core/agent/agent.dart';
import 'package:crossworduel/game/game-core/mock/mock.dart';
import 'package:crossworduel/game/domain/entities/player_entity.dart';

typedef PlayerStateCreator = PlayerEntity Function({required UserEntity me});

class GameConfig {
  final MockParent mock;
  final PlayerStateCreator playerStateCreator;
  final Map<String, ParentAgent Function(ParentAgentConfig config)>
      agentsCreator;

  GameConfig({
    required this.playerStateCreator,
    required this.agentsCreator,
    required this.mock,
  });
}
