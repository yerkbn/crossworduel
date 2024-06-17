import 'package:crossworduel/config/app/app_sl.dart';
import 'package:crossworduel/config/network/custom_dio.dart';
import 'package:crossworduel/core/local-pub/custom_storage/custom_storage.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/crossword/crossword_sl.dart';
import 'package:crossworduel/features/profile/profile_sl.dart';
import 'package:crossworduel/features/unauth/unauth_sl.dart';
import 'package:crossworduel/navigation/auth_navigation.dart';
import 'package:crossworduel/navigation/navigation.dart';
import 'package:crossworduel/navigation/unauth_navigation.dart';
import 'package:flutter/material.dart';

class AppWrapper extends StatelessWidget {
  final AppSl appSl;

  const AppWrapper({
    super.key,
    required this.appSl,
  });

  @override
  Widget build(BuildContext context) {
    return const MainNavigation();
  }

  Future<void> init() async {
    await ServiceLocatorManager.init(
      services: [
        AuthNavigation(routeObserver: RouteObserver<ModalRoute>()),
        UnauthNavigation(),
        CustomAuthDio(backendUrl: appSl.networkConfig.globalBackendUrl),
        CustomUnauthDio(backendUrl: appSl.networkConfig.globalBackendUrl),
        SecureCustomStorage(),
        UnauthServiceLocator(),
        ProfileServiceLocator(),
        CrosswordServiceLocator(),
        appSl,
      ],
    );
  }
}
