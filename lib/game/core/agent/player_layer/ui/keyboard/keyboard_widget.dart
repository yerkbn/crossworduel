import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/game/core/agent/player_layer/player_event.dart';
import 'package:crossworduel/game/core/game/bloc/game_bloc.dart';
import 'package:crossworduel/game/core/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KeyboardWidget extends StatelessWidget {
  const KeyboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: Sizer().getHeight(582)),
        width: Sizer().getWidth(375),
        height: Sizer().getHeight(200),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _buildLetter(context, "Q"),
              _buildLetter(context, "W"),
              _buildLetter(context, "E"),
              _buildLetter(context, "R"),
              _buildLetter(context, "T"),
              _buildLetter(context, "Y"),
              _buildLetter(context, "U"),
              _buildLetter(context, "I"),
              _buildLetter(context, "O"),
              _buildLetter(context, "P"),
            ]),
            4.ph,
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _buildLetter(context, "A"),
              _buildLetter(context, "S"),
              _buildLetter(context, "D"),
              _buildLetter(context, "F"),
              _buildLetter(context, "G"),
              _buildLetter(context, "H"),
              _buildLetter(context, "J"),
              _buildLetter(context, "K"),
              _buildLetter(context, "L"),
            ]),
            4.ph,
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _buildLetter(context, "+"),
              _buildLetter(context, "Z"),
              _buildLetter(context, "X"),
              _buildLetter(context, "C"),
              _buildLetter(context, "V"),
              _buildLetter(context, "B"),
              _buildLetter(context, "N"),
              _buildLetter(context, "M"),
              _buildLetter(context, "<=", onTap: () {
                BlocProvider.of<GameBloc>(context)
                    .add(const DeleteTapGameEvent());
              }),
            ]),
          ],
        ));
  }

  Widget _buildLetter(BuildContext context, String letter,
      {Function()? onTap}) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return CustomContainer(
      width: Sizer().getWidth(33),
      height: Sizer().getHeight(54),
      topMargin: 0,
      leftMargin: Sizer().getWidth(2),
      rightMargin: Sizer().getWidth(2),
      onPressed: onTap ??
          () {
            BlocProvider.of<GameBloc>(context)
                .add(KeyboardTapGameEvent(letter: letter));
          },
      borderRadius: Sizer().getWidth(4),
      color: theme.backgroundColor3,
      borderColor: theme.backgroundColor2,
      paddingSize: 0,
      child: Text(letter.toUpperCase(),
          style: theme.headline2.copyWith(
            color: Colors.black,
            fontSize: Sizer().getSp(14),
          )),
    );
  }
}
