import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LevelItemWidget extends StatefulWidget {
  final String levelName;
  final int level;
  final int wins;
  const LevelItemWidget({
    super.key,
    required this.level,
    required this.levelName,
    required this.wins,
  });

  @override
  State<LevelItemWidget> createState() => _LevelItemWidgetState();
}

class _LevelItemWidgetState extends State<LevelItemWidget> {
  double _width = 0;
  final double _levelHeight = 24.h;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _width = 324.h * (widget.wins / 100);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return CustomContainer(
      topMargin: 0,
      paddingSize: 12.h,
      onPressed: () {},
      color: theme.backgroundColor3,
      borderColor: theme.backgroundColor2,
      borderRadius: 4.sp,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "LEVEL: ${widget.levelName}",
                style: theme.headline3.copyWith(
                  color: theme.textColor1,
                  fontSize: 16.h,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 6.w),
                child: Text(
                  'WINS ${widget.wins}/100',
                  style: theme.headline4.copyWith(color: theme.textColor2),
                ),
              ),
            ],
          ),
          10.ph,
          Container(
            height: _levelHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.sp),
              color: theme.backgroundColor2,
            ),
            child: Stack(
              children: [
                AnimatedContainer(
                  width: _width,
                  height: _levelHeight,
                  curve: Curves.easeOutQuad,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    height: _levelHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.sp),
                      gradient: LinearGradient(colors: <Color>[
                        const Color(0xFF6FCF97).withOpacity(.8),
                        const Color(0xFF6FCF97),
                      ]),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${widget.level}",
                          style: theme.headline3
                              .copyWith(color: Colors.white, fontSize: 16.h),
                        ),
                        Text(
                          "${widget.level + 1}",
                          style: theme.headline3
                              .copyWith(color: Colors.white, fontSize: 16.h),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          8.ph,
        ],
      ),
    );
  }
}
