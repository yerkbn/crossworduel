import 'package:crossworduel/core/local-pub/vector/vector.dart';
import 'package:crossworduel/game/domain/entities/player_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingScreen extends StatefulWidget {
  final PlayerEntity me; // the my personal data
  final PlayerEntity? opponent; // the oponent if not found it will be null

  const LoadingScreen({required this.me, this.opponent});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/background/oof.png'))),
        ),
        _buildOponent(position: const Vector(100, 200), player: widget.me),
        if (widget.opponent == null)
          Positioned(
            left: ScreenUtil().setWidth(600),
            top: ScreenUtil().setHeight(1500),
            child: Text(
              'Loading ...',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: ScreenUtil().setSp(70), color: Colors.black),
            ),
          )
        else
          _buildOponent(
              position: const Vector(600, 1300), player: widget.opponent!),
      ],
    );
  }

  Widget _buildOponent({
    required Vector position,
    required PlayerEntity player,
  }) {
    return Positioned(
      left: ScreenUtil().setWidth(position.x),
      top: ScreenUtil().setHeight(position.y),
      child: SizedBox(
        width: ScreenUtil().setWidth(350),
        height: ScreenUtil().setWidth(500),
        // color: Colors.red,
        child: Column(
          children: [
            Container(
                width: ScreenUtil().setWidth(340),
                height: ScreenUtil().setWidth(340),
                margin:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(player.avatar),
                )),
            Text(
              player.username,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: ScreenUtil().setSp(60), color: Colors.black),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(200),
              child: Row(children: [
                SizedBox(
                  width: ScreenUtil().setWidth(60),
                  height: ScreenUtil().setHeight(60),
                  child: Image.asset('assets/icons/fire.png'),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(10),
                ),
                Text(
                  "9999",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: ScreenUtil().setSp(55), color: Colors.black),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
