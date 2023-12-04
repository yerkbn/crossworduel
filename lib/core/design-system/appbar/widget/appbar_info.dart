import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:crossworduel/config/ui/custom_theme_extension.dart';

class AppBarInfo extends StatelessWidget {
  final String value;
  final String icon;
  final void Function() onTap;

  const AppBarInfo({
    super.key,
    required this.value,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Padding(
      padding: EdgeInsets.only(right: 4.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.sp),
            color: theme.backgroundColor4,
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                height: 16.h,
                width: 16.w,
              ),
              SizedBox(width: 4.w),
              Text(
                value,
                style: theme.headline1
                    .copyWith(color: Colors.white, fontSize: 16.sp),
              ),
              SizedBox(width: 2.w),
            ],
          ),
        ),
      ),
    );
  }
}
