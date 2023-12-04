import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/core/util/sizer/sizer.dart';
import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  final bool isLeft;
  const UserItem({super.key, required this.isLeft});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizer().getHeight(44),
      width: Sizer().getWidth(162),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment:
            isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          isLeft ? _buildAvatar : _buildName(context),
          8.pw,
          isLeft ? _buildName(context) : _buildAvatar,
        ],
      ),
    );
  }

  Widget get _buildAvatar => Container(
      width: Sizer().getHeight(44),
      height: Sizer().getHeight(44),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizer().getSp(4)),
          image: const DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              "https://www.stylerave.com/wp-content/uploads/2022/11/1000-x-1000-5-2.png",
            ),
          )));

  Widget _buildName(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Column(
      crossAxisAlignment:
          isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text("@samaltman", style: theme.headline4),
        Text("424", style: theme.headline1),
      ],
    );
  }
}
