import 'package:crossworduel/core/service-locator/service_locator.dart';
import 'package:crossworduel/features/crossword/presentation/pages/crossword_detail_page.dart';
import 'package:crossworduel/features/crossword/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class AuthNavigation implements ServiceLocator {
  static const String main = '/';
  static const String detail = '/detail';

  final RouteObserver<ModalRoute> routeObserver;
  // static final RouteObserver<PageRoute> _routeObserver =
  //     RouteObserver<PageRoute>();

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
            return const MainPage();
          },
        ),
        GoRoute(
          path: detail,
          builder: (BuildContext context, GoRouterState state) {
            return const CrosswordDetailPage();
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
          return const MainPage();
        },
      ),
      GoRoute(
        path: detail,
        builder: (BuildContext context, GoRouterState state) {
          // final CrosswordEntity arg = state.extra as CrosswordEntity;
          return const CrosswordDetailPage();
        },
      ),
    ]);
  }

  @override
  Future<void> call(GetIt sl) async {
    sl.registerLazySingleton<AuthNavigation>(() => this);
  }
}
