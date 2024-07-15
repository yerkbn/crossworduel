import 'package:crossworduel/core/service-locator/service_locator.dart';
import 'package:crossworduel/features/crossword/domain/entities/crossword_entity.dart';
import 'package:crossworduel/features/crossword/presentation/pages/crossword_create_page.dart';
import 'package:crossworduel/features/crossword/presentation/pages/crossword_detail_page.dart';
import 'package:crossworduel/features/crossword/presentation/pages/crossword_run_page.dart';
import 'package:crossworduel/features/crossword/presentation/pages/main_page.dart';
import 'package:crossworduel/features/profile/domain/entities/user_entity.dart';
import 'package:crossworduel/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class AuthNavigation implements ServiceLocator {
  static const String main = '/';
  static const String detail = '/detail';
  static const String run = '/run';
  static const String create = '/create';
  static const String profile = '/profile';

  static const Duration navigationDuration = Duration(milliseconds: 150);
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
          name: detail,
          path: detail,
          pageBuilder: (context, state) {
            final CrosswordEntity arg = state.extra as CrosswordEntity;
            return CustomTransitionPage(
              key: state.pageKey,
              child: CrosswordDetailPage(crosswordEntity: arg),
              transitionDuration: navigationDuration,
              reverseTransitionDuration: navigationDuration,
              transitionsBuilder: (_, a, __, c) =>
                  FadeTransition(opacity: a, child: c),
            );
          },
        ),
        GoRoute(
          name: run,
          path: run,
          pageBuilder: (context, state) {
            final CrosswordEntity arg = state.extra as CrosswordEntity;
            return CustomTransitionPage(
              key: state.pageKey,
              child: CrosswordRunPage(crosswordEntity: arg),
              transitionDuration: navigationDuration,
              transitionsBuilder: (_, a, __, c) =>
                  FadeTransition(opacity: a, child: c),
            );
          },
        ),
        GoRoute(
          name: create,
          path: create,
          pageBuilder: (context, state) {
            final CrosswordEntity arg = state.extra as CrosswordEntity;
            return CustomTransitionPage(
              key: state.pageKey,
              child: CrosswordCreatePage(crosswordEntity: arg),
              transitionDuration: navigationDuration,
              transitionsBuilder: (_, a, __, c) =>
                  FadeTransition(opacity: a, child: c),
            );
          },
        ),
        GoRoute(
          name: profile,
          path: profile,
          builder: (context, state) {
            final UserEntity arg = state.extra as UserEntity;
            return ProfilePage(userEntity: arg);
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
        name: detail,
        path: detail,
        pageBuilder: (context, state) {
          final CrosswordEntity arg = state.extra as CrosswordEntity;
          return CustomTransitionPage(
            key: state.pageKey,
            child: CrosswordDetailPage(crosswordEntity: arg),
            transitionDuration: navigationDuration,
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c),
          );
        },
      ),
      GoRoute(
        name: run,
        path: run,
        pageBuilder: (context, state) {
          final CrosswordEntity arg = state.extra as CrosswordEntity;
          return CustomTransitionPage(
            key: state.pageKey,
            child: CrosswordRunPage(crosswordEntity: arg),
            transitionDuration: navigationDuration,
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c),
          );
        },
      ),
      GoRoute(
        name: create,
        path: create,
        pageBuilder: (context, state) {
          final CrosswordEntity arg = state.extra as CrosswordEntity;
          return CustomTransitionPage(
            key: state.pageKey,
            child: CrosswordCreatePage(crosswordEntity: arg),
            transitionDuration: navigationDuration,
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c),
          );
        },
      ),
    ]);
  }

  @override
  Future<void> call(GetIt sl) async {
    sl.registerLazySingleton<AuthNavigation>(() => this);
  }
}
