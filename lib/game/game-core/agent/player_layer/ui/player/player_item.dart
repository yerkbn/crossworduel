import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/game/domain/entities/player_entity.dart';
import 'package:crossworduel/game/game-core/agent/player_layer/ui/player/shadow_andimation.dart';
import 'package:crossworduel/game/game-core/crossword/entity/span_entity.dart';
import 'package:crossworduel/game/game-core/sizer/sizer.dart';
import 'package:flutter/material.dart';

class PlayerItem extends StatefulWidget {
  final bool isLeft;
  final PlayerEntity player;
  final Widget? rightWidget;
  final bool isGame;
  const PlayerItem({
    super.key,
    required this.player,
    required this.isLeft,
    this.rightWidget,
    this.isGame = true,
  });

  @override
  State<PlayerItem> createState() => PlayerItemState();
}

class PlayerItemState extends State<PlayerItem>
    with SingleTickerProviderStateMixin {
  /// Animation
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));

    final Animation<double> curve =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);

    _animation = Tween<double>(begin: 0, end: 1).animate(curve)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        }
      });
  }

  void lightUp(SpanEntity span) {
    _animationController.forward();
  }

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
          if (widget.rightWidget != null) Expanded(child: 0.ph),
          if (widget.rightWidget != null) widget.rightWidget!,
        ],
      ),
    );
  }

  Widget get _buildAvatar => ShadowAnimation(
        animation: _animation,
        color: const Color(0xFF6FCF97),
        child: Container(
            width: Sizer().getHeight(44),
            height: Sizer().getHeight(44),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizer().getSp(4)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    widget.player.avatar,
                  ),
                ))),
      );

  Widget _buildName(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Column(
      crossAxisAlignment:
          widget.isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(widget.player.username,
            style: theme.headline4.copyWith(fontSize: Sizer().getHeight(12))),
        Text(
            widget.isGame
                ? widget.player.getProgressPoint
                : widget.player.getPoint,
            style: theme.headline1.copyWith(fontSize: Sizer().getHeight(18))),
      ],
    );
  }
}
