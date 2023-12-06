import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/core/util/sizer/sizer.dart';
import 'package:crossworduel/game/domain/entities/player_entity.dart';
import 'package:flutter/material.dart';

class PlayerItem extends StatefulWidget {
  final bool isLeft;
  final PlayerEntity player;
  const PlayerItem({super.key, required this.player, required this.isLeft});

  @override
  State<PlayerItem> createState() => PlayerItemState();
}

class PlayerItemState extends State<PlayerItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizer().getHeight(44),
      width: Sizer().getWidth(162),
      child: Row(
        mainAxisAlignment:
            widget.isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (widget.isLeft) _buildAvatar else _buildName(context),
          8.pw,
          if (widget.isLeft) _buildName(context) else _buildAvatar,
        ],
      ),
    );
  }

  Widget get _buildAvatar => Container(
      width: Sizer().getHeight(44),
      height: Sizer().getHeight(44),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizer().getSp(4)),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              widget.player.avatar,
            ),
          )));

  Widget _buildName(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Column(
      crossAxisAlignment:
          widget.isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(widget.player.username, style: theme.headline4),
        Text("424", style: theme.headline1),
      ],
    );
  }
}
