import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/profile/presentation/bloc/refresh/refresh_bloc.dart';
import 'package:crossworduel/features/unauth/domain/entities/me_entity.dart';
import 'package:crossworduel/features/unauth/presentation/bloc/auth/auth_bloc.dart';
import 'package:crossworduel/game/game-core/agent/agent.dart';
import 'package:crossworduel/game/game-core/agent/game_agent/game_agent.dart';
import 'package:crossworduel/game/game-core/bridge/game_status.dart';
import 'package:crossworduel/game/game-core/game/bloc/game_bloc.dart';
import 'package:crossworduel/game/domain/entities/room_entity.dart';
import 'package:crossworduel/game/presentation/ui/widget/table/game_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// This is bridge means that
/// package to clients
/// here will be passed most neccesary
/// parameters. In other word it acts like driver
/// to connect package
class GameBridge extends StatefulWidget {
  final MeEntity me;
  final RoomEntity parameter;
  final GameMockCreator mockCreator;
  final RouteObserver<PageRoute> routeObserver;
  final bool isTesting;

  const GameBridge(
      {required this.me,
      required this.parameter,
      required this.routeObserver,
      required this.mockCreator,
      required this.isTesting});
  @override
  State<StatefulWidget> createState() {
    return _GameBridge();
  }
}

class _GameBridge extends State<GameBridge> with RouteAware {
  late ParentAgent _gameAgent;

  @override
  void initState() {
    _gameAgent = GameAgent.agentCreator(widget.me);
    GameBloc gameBloc = GameBloc(
      authBloc: globalSL<AuthBloc>(),
      gameMockCreator: widget.mockCreator,
      currentUser: widget.me,
      gameAgent: _gameAgent,
      routeParameter: widget.parameter,
      isTesting: widget.isTesting,
    );

    if (globalSL.isRegistered<GameBloc>()) {
      globalSL.unregister<GameBloc>();
      globalSL.registerLazySingleton(() => gameBloc,
          dispose: (GameBloc bloc) => bloc.close());
    } else {
      globalSL.registerLazySingleton(() => gameBloc,
          dispose: (GameBloc bloc) => bloc.close());
    }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // widget.routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    widget.routeObserver.unsubscribe(this);
    globalSL.unregister<GameBloc>();
    super.dispose();
  }

  /// Called when the current route has been popped off.
  /// [INVISIBLE] this will be called to server that player leave the game
  void didPop() {
    globalSL<GameBloc>().add(PlayerLeaveGameEvent(playerId: widget.me.id));
    BlocProvider.of<RefreshBloc>(context).refresh();
  }

  void serverFault({String url = '/'}) {
    globalSL<GameBloc>().close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: globalSL<GameBloc>(),
      listener: (BuildContext context, GameState state) {
        if (state is AFKGameState) {
          serverFault();
        }
      },
      builder: (BuildContext context, GameState state) {
        if (state is RunningGameState) {
          return GameTable(gameAgent: _gameAgent);
        }
        if (state is FailureGameState) {
          return GameStatus(
            message: state.error,
            icon: Icons.report_problem,
          );
        }
        if (state is AFKGameState) {
          return const GameStatus(
            message: 'You have been expelled for inaction!',
            subtitle:
                "Please pay attention to the timer next time and don't miss your turn.",
            icon: Icons.report_problem,
          );
        }
        if (state is LoadingGameState) {
          return const GameStatus(
            message: 'Loading...',
            icon: Icons.hourglass_empty,
          );
        }
        return const GameStatus(
          message: 'Loading...',
          icon: Icons.hourglass_empty,
        );
      },
    );
  }
}
