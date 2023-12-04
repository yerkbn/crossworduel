import 'package:crossworduel/core/service-locator/service_locator.dart';
import 'package:crossworduel/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class AuthNavigation implements ServiceLocator {
  static const String main = '/';
  static const String play = '/play';
  static const String user = '/user';
  static const String profileSettings = '/profile_settings';
  static const String friends = '/friends';
  static const String searchFriends = '/friends_search';
  static const String inviteFriend = '/invite_friend';
  static const String questionAnalysis = '/question_analysis';

  final RouteObserver<ModalRoute> routeObserver;

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
