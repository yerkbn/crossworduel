import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/appbar/main_app_bar.dart';
import 'package:crossworduel/core/design-system/button/custom_button.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/unauth/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final RefreshController _refreshController = RefreshController();

  Future<void> _onRefresh() async {
    _refreshController.refreshCompleted();
    globalSL<AuthBloc>().add(RefreshAuthEvent());
  }

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Scaffold(
      appBar: MainAppBar(
        withBack: true,
        isProfileNavigationEnabled: false,
      ),
      backgroundColor: theme.backgroundColor2,
      body: Center(
        child: CustomButton.h2(
            width: 164,
            title: "Log out",
            color: theme.backgroundColor4,
            onPressed: () {
              globalSL<AuthBloc>().signout();
            }),
      ),
    );
  }
}
