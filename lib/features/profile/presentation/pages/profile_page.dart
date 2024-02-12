import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/profile/presentation/widgets/history/history_widget.dart';
import 'package:crossworduel/features/profile/presentation/widgets/statistics/statistics_widget.dart';
import 'package:crossworduel/features/unauth/presentation/bloc/auth/auth_bloc.dart';
import 'package:crossworduel/game/game-core/agent/player_layer/ui/player/player_item.dart';
import 'package:crossworduel/game/domain/entities/player_entity.dart';
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
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor1,
      body: BlocBuilder<AuthBloc, AuthState>(
        bloc: globalSL<AuthBloc>(),
        builder: (context, state) {
          if (state is AuthenticatedAuthState) {
            return SmartRefresher(
              header: const WaterDropHeader(),
              onRefresh: _onRefresh,
              controller: _refreshController,
              child: Column(
                children: [
                  82.ph,
                  SizedBox(
                      width: 316.w,
                      height: 44.h,
                      child: PlayerItem(
                        isLeft: true,
                        isGame: false,
                        player: PlayerEntity.fromMe(state.me),
                        // rightWidget: CustomContainer(
                        //   width: 36.w,
                        //   height: 36.w,
                        //   paddingSize: 0,
                        //   topMargin: 0,
                        //   borderRadius: 4.r,
                        //   borderColor: theme.backgroundColor2,
                        //   color: theme.backgroundColor3,
                        //   onPressed: () {},
                        //   child: Icon(Icons.settings_suggest,
                        //       color: theme.textColor1, size: 20.r),
                        // ),
                      )),
                  24.ph,
                  const StatisticsWidget(),
                  6.ph,
                  Expanded(
                    child: SizedBox(
                      width: 316.w,
                      height: 100.h,
                      child: const HistoryWidget(),
                    ),
                  ),
                  12.ph,
                  CustomContainer(
                      width: 184.w,
                      height: 36.h,
                      paddingSize: 0,
                      topMargin: 0,
                      borderRadius: 4.sp,
                      color: theme.backgroundColor3,
                      borderColor: theme.backgroundColor2,
                      child: Text("PLAY", style: theme.headline3),
                      onPressed: () {
                        globalSL<AuthNavigation>().globalRouter.push(
                            AuthNavigation.play,
                            extra: RoomEntity(
                                createRoom: RoomCreateEntity(subjectId: "1")));
                      }),
                  64.ph
                ],
              ),
            );
          }
          return 0.ph;
        },
      ),
    );
  }
}
