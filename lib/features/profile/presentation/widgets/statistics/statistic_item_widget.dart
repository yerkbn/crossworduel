import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatisticItemWidget extends StatefulWidget {
  const StatisticItemWidget({super.key});

  @override
  State<StatisticItemWidget> createState() => _StatisticItemWidgetState();
}

class _StatisticItemWidgetState extends State<StatisticItemWidget> {
  double _width = 0;
  final double _levelHeight = 24.h;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _width = 324.h * .4;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return CustomContainer(
      topMargin: 0,
      width: 300.w,
      paddingHorizantal: 12.h,
      paddingSize: 8.h,
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
                "LEVEL: BABY",
                style: theme.headline3.copyWith(
                  color: theme.textColor1,
                  fontSize: 16.h,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 6.w),
                child: Text(
                  'WINS 54/100',
                  style: theme.headline4.copyWith(color: theme.textColor2),
                ),
              ),
            ],
          ),
          4.ph,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
