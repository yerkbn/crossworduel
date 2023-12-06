import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/config/ui/ui_config.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/core/local-pub/vector/vector.dart';
import 'package:crossworduel/game/core/animation/animation_item.dart';
import 'package:crossworduel/game/domain/entities/player_entity.dart';
import 'package:crossworduel/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingController extends StatefulWidget {
  final PlayerEntity me;

  const LoadingController({
    required this.me,
    required Key key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return LoadingControllerState();
  }
}

class LoadingControllerState extends State<LoadingController>
    with TickerProviderStateMixin {
  /// Global keys
  final GlobalKey<AnimationItemState> _leftKey =
      GlobalKey<AnimationItemState>();
  final GlobalKey<AnimationItemState> _rightKey =
      GlobalKey<AnimationItemState>();

  final GlobalKey<AnimationItemState> _readyKey =
      GlobalKey<AnimationItemState>();

  final Vector _openPosition =
      const Vector(UiConfig.globalWidth / 2, UiConfig.globalHeight / 2);
  final Vector _hiddenLeft =
      const Vector(-UiConfig.globalWidth, UiConfig.globalHeight / 2);
  final Vector _hiddenRight =
      const Vector(UiConfig.globalWidth * 2, UiConfig.globalHeight / 2);
  final Vector _readySize = const Vector(350, 350);
  final int _messageDuration = 800;
  final int _positionDuration = 400;

  /// Mutible data
  bool _isVisible = true;
  bool _isBackgroundVisible = true;
  PlayerEntity? _opponent;

  @override
  void initState() {
    super.initState();
    loadingStart();
  }

  void _close() {
    _rightKey.currentState!.toPosition(_hiddenRight);
    _leftKey.currentState!.toPosition(_hiddenLeft);
    _readyKey.currentState!.openChild2();
  }

  Future<void> _showLabel() async {
    _readyKey.currentState!.toSize(_readySize);
    _readyKey.currentState!.toPosition(_openPosition);
  }

  /// Oponent found start all animations
  Future<void> setOpponent(PlayerEntity? opponent) async {
    setState(() => _opponent = opponent);
    _rightKey.currentState!.toPosition(_openPosition);

    Future.delayed(Duration(milliseconds: _positionDuration * 2), () {
      setState(() {
        _isBackgroundVisible = false;
      });
    });
  }

  Future<void> loadingStart() async {
    setState(() {
      _isVisible = true;
    });
    Future.delayed(const Duration(milliseconds: 150), () {
      _leftKey.currentState!.toPosition(_openPosition);
    });
  }

  Future<void> loadingEnd() async {
    if (!_isVisible) return;
    await Future.delayed(const Duration(milliseconds: 1000));
    _showLabel();
    await Future.delayed(Duration(milliseconds: _messageDuration));
    _close();
    await Future.delayed(Duration(milliseconds: _messageDuration));
    setState(() {
      _isVisible = false;
      _opponent = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isVisible ? _buildVisible : 0.ph;
  }

  Widget get _buildVisible {
    final double w = UiConfig.globalWidth.w;
    final double h = UiConfig.globalHeight.h;
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Stack(
      children: [
        if (_isBackgroundVisible)
          Container(
            width: w,
            height: h,
            color: theme.backgroundColor2,
            child: _buildUser(null, Alignment.bottomRight),
          )
        else
          Container(),
        AnimationItem(

            /// RIGHT
            key: _rightKey,
            initialParameters: AnimationParameters(
                positionDuration: _positionDuration,
                angle: 0,
                position: _hiddenRight,
                size: const Vector(
                    UiConfig.globalWidth * 1.1, UiConfig.globalHeight * 1.1)),
            child2: 0.ph,
            child1: Container(
                width: w * 1.1,
                height: h * 1.1,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(Assets.image.rightLoading.path))),
                child: _buildUser(_opponent, Alignment.bottomRight))),
        AnimationItem(

            /// LEFT
            key: _leftKey,
            initialParameters: AnimationParameters(
                angle: 0,
                position: _hiddenLeft,
                positionDuration: _positionDuration,
                size: const Vector(
                    UiConfig.globalWidth * 1.1, UiConfig.globalHeight * 1.1)),
            child2: 0.ph,
            child1: Container(
                width: w * 1.1,
                height: h * 1.1,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(Assets.image.leftLoading.path))),
                child: _buildUser(widget.me, Alignment.topLeft))),
        AnimationItem(
            key: _readyKey,
            initialParameters: AnimationParameters(
                curve: Curves.linear,
                sizeDuration: _messageDuration,
                positionDuration: _messageDuration,
                angle: 0,
                position: _openPosition + (_readySize.divide(2)),
                size: const Vector(0, 0)),
            child2: Container(),
            child1: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(Assets.image.go.path))),
            )),
      ],
    );
  }

  Widget _buildUser(PlayerEntity? player, Alignment alignment) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    late Widget result;
    if (player != null) {
      result = SizedBox(
        width: 182.w,
        height: 242.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 92.w,
                height: 92.w,
                child:
                    CircleAvatar(backgroundImage: NetworkImage(player.avatar))),
            8.ph,
            Text(player.username,
                style: theme.headline1.copyWith(color: Colors.white)),
            4.ph,
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Assets.icons.apple.image(width: 14.h),
              8.pw,
              Text("1998", style: theme.headline2.copyWith(color: Colors.white))
            ])
          ],
        ),
      );
    } else {
      result = Text('Looking for...', style: theme.headline1);
    }

    return Align(
      alignment: alignment,
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 150.h, horizontal: 40.w),
          child: result),
    );
  }
}
