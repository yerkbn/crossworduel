import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/unauth/presentation/bloc/auth/auth_bloc.dart';
import 'package:crossworduel/game/game-core/bridge/game_bridge.dart';
import 'package:crossworduel/game/game-core/mock/mock.dart';
import 'package:crossworduel/game/game-core/mock/mock_game/mock_game.dart';
import 'package:crossworduel/game/domain/entities/room_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// but main porpose is getting user info from
/// shared preference and pass it to azi bloc
/// by child
class GamePage extends StatefulWidget {
  final RoomEntity arg;
  final RouteObserver<PageRoute> routeObserver;

  const GamePage({
    required this.routeObserver,
    required this.arg,
  });

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with RouteAware {
  RoomEntity get arg => widget.arg;

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor1,
      body: ColoredBox(
        color: theme.primaryColor,
        child: BlocBuilder<AuthBloc, AuthState>(
          bloc: globalSL<AuthBloc>(),
          builder: (BuildContext context, AuthState state) {
            if (state is AuthenticatedAuthState) {
              return GameBridge(
                isTesting: true,
                mockCreator: (MockConfig config) {
                  return MockGame(config);
                },
                routeObserver: widget.routeObserver,
                me: state.me,
                parameter: arg,
              );
            }
            return const Text('Not user found');
          },
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  @override
  void dispose() {
    widget.routeObserver.unsubscribe(this);
    // Screen.keepOn(false);
    super.dispose();
  }

  /// Route was pushed onto navigator and is now topmost route.
  /// [VISIBLE]
  void didPush() {}

  /// Covering route was popped off the navigator.
  /// from other page [VISIBLE]
  void didPopNext() {}

  /// Called when the current route has been popped off.
  /// [INVISIBLE]
  void didPop() {
    // Messages comming to app will be turn off
    // BlocProvider.of<AppsocketBloc>(context).add(ReconnectAppsocketEvent());
  }

  /// Called when a new route has been pushed, and the current route is no
  /// longer visible. [INVISIBLE]
  void didPushNext() {
    // Messages comming to app will be turn off
    // BlocProvider.of<AppsocketBloc>(context).add(ReconnectAppsocketEvent());
  }
}
