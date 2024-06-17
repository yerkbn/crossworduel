import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingWidget extends StatefulWidget {
  const RatingWidget({super.key});

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  int _star = 4;

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return CustomContainer(
      width: 343.w,
      color: theme.backgroundColor3,
      paddingVertical: 6.h,
      topMargin: 0,
      borderRadius: 8.r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 64.w,
            alignment: Alignment.centerLeft,
            child: Text(
              "${_star}/5",
              style: theme.headline2,
            ),
          ),
          Row(
            children: [
              for (int i = 0; i < 5; i++)
                CustomContainer(
                  topMargin: 0,
                  paddingVertical: 0,
                  paddingHorizantal: 4,
                  color: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      _star = i + 1;
                    });
                  },
                  child: Assets.icons.star.image(
                      height: 24.h,
                      color:
                          ((i + 1) <= _star) ? null : theme.backgroundColor4),
                ),
            ],
          ),
          Container(
            width: 64.w,
            alignment: Alignment.centerRight,
            child: CustomContainer(
              paddingVertical: 4.h,
              paddingHorizantal: 8.w,
              topMargin: 0,
              borderRadius: 6.r,
              color: theme.backgroundColor3,
              borderColor: theme.backgroundColor4,
              child: Text("SAVE",
                  style: theme.headline3.copyWith(fontSize: 12.sp)),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
