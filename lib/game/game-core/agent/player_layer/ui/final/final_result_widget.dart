import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/profile/domain/entities/history_entity.dart';
import 'package:crossworduel/features/profile/presentation/bloc/refresh/refresh_bloc.dart';
import 'package:crossworduel/game/game-core/sizer/sizer.dart';
import 'package:crossworduel/navigation/auth_navigation.dart';
import 'package:flutter/material.dart';

class FinalResultWidget extends StatefulWidget {
  final HistoryEntity historyEntity;
  const FinalResultWidget({super.key, required this.historyEntity});

  @override
  State<FinalResultWidget> createState() => _FinalResultWidgetState();
}

class _FinalResultWidgetState extends State<FinalResultWidget> {
  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(top: Sizer().getHeight(164)),
      child: Container(
        color: theme.backgroundColor1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.historyEntity.meDelta.toString(),
                style: theme.headline3.copyWith(fontSize: Sizer().getSp(54))),
            Text("Game over!",
                style: theme.headline3.copyWith(fontSize: Sizer().getSp(42))),
            SizedBox(height: Sizer().getHeight(42)),
            CustomContainer(
                width: Sizer().getWidth(184),
                height: Sizer().getHeight(36),
                paddingSize: 0,
                topMargin: 0,
                borderRadius: 4,
                color: theme.backgroundColor3,
                borderColor: theme.backgroundColor2,
                child: Text("LEAVE", style: theme.headline3),
                onPressed: () {
                  globalSL<RefreshBloc>().refresh();
                  globalSL<AuthNavigation>().globalRouter.pop();
                }),
          ],
        ),
      ),
    );
  }
}
