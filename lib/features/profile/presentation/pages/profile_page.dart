import 'package:crossworduel/core/design-system/button/custom_button.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/unauth/presentation/bloc/auth/auth_bloc.dart';
import 'package:crossworduel/game/domain/entities/room_entity.dart';
import 'package:crossworduel/navigation/auth_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        bloc: globalSL<AuthBloc>(),
        builder: (context, state) {
          if (state is AuthenticatedAuthState) {
            return SmartRefresher(
              header: const WaterDropHeader(),
              onRefresh: _onRefresh,
              controller: _refreshController,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    562.ph,
                    CustomButton.h2(
                      width: 184.w,
                      title: "Play",
                      textColor: Colors.white,
                      onPressed: () {
                        globalSL<AuthNavigation>().globalRouter.push(
                            AuthNavigation.play,
                            extra: RoomEntity(
                                createRoom: RoomCreateEntity(subjectId: "1")));
                      },
                    ),
                    16.ph,
                    CustomButton.h2(
                      width: 184.w,
                      title: "Leave",
                      textColor: Colors.white,
                      onPressed: () {
                        globalSL<AuthBloc>().add(LogOutAuthEvent());
                      },
                    )
                  ],
                ),
              ),
            );
          }
          return 0.ph;
        },
      ),
    );
  }
}
