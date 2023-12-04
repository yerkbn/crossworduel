import 'package:crossworduel/core/util/sizer/sizer.dart';
import 'package:crossworduel/game/presentation/ui/widget/users/user_item.dart';
import 'package:flutter/material.dart';

class TopUsersWidget extends StatefulWidget {
  const TopUsersWidget({super.key});

  @override
  State<TopUsersWidget> createState() => _TopUsersWidgetState();
}

class _TopUsersWidgetState extends State<TopUsersWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Sizer().getHeight(116)),
      // color: Colors.black,
      width: Sizer().getHeight(327),
      height: Sizer().getHeight(44),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UserItem(isLeft: true),
          UserItem(isLeft: false),
        ],
      ),
    );
  }
}
