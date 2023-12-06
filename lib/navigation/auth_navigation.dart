import 'package:crossworduel/core/service-locator/service_locator.dart';
import 'package:crossworduel/features/profile/presentation/pages/profile_page.dart';
import 'package:crossworduel/game/domain/entities/room_entity.dart';
import 'package:crossworduel/game/presentation/ui/page/game_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class AuthNavigation implements ServiceLocator {
  static const String main = '/';
  static const String play = '/play';

  final RouteObserver<ModalRoute> routeObserver;
  static final RouteObserver<PageRoute> _routeObserver =
      RouteObserver<PageRoute>();

  final GoRouter globalRouter;
  final GoRouter mainRoutes;

  AuthNavigation({required this.routeObserver})
      : globalRouter = _globalRouter(routeObserver),
        mainRoutes = _mainRoutes;

  static GoRouter _globalRouter(RouteObserver<ModalRoute> routeObserver) {
    return GoRouter(
      observers: [routeObserver],
      routes: <GoRoute>[
        GoRoute(
          path: main,
          builder: (BuildContext context, GoRouterState state) {
            return const ProfilePage();
          },
        ),
        GoRoute(
          path: play,
          builder: (BuildContext context, GoRouterState state) {
            final RoomEntity arg = state.extra! as RoomEntity;
            return GamePage(routeObserver: _routeObserver, arg: arg);
          },
        ),
      ],
    );
  }

  static GoRouter get _mainRoutes {
    return GoRouter(routes: [
      GoRoute(
        path: main,
        builder: (BuildContext context, GoRouterState state) {
          return const ProfilePage();
        },
      ),
    ]);
  }

  @override
  Future<void> call(GetIt sl) async {
    sl.registerLazySingleton<AuthNavigation>(() => this);
  }
}
