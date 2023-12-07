import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/game/core/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HintWidget extends StatelessWidget {
  const HintWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Container(
      margin: EdgeInsets.only(top: Sizer().getHeight(516)),
      width: Sizer().getWidth(327),
      height: Sizer().getHeight(50),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomContainer(
              width: Sizer().getWidth(28),
              height: Sizer().getWidth(28),
              topMargin: 0,
              onPressed: () {},
              borderRadius: 4.sp,
              color: theme.backgroundColor3,
              borderColor: theme.backgroundColor2,
              paddingSize: 0,
              child: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.black,
                size: 14.h,
              ),
            ),
            SizedBox(
              width: Sizer().getWidth(250),
              child: Text(
                "How to sort a list of objects by the alphabetical order of one of its properties sort a list of objects by the alphabetica",
                textAlign: TextAlign.center,
                style: theme.headline3.copyWith(fontSize: Sizer().getSp(12)),
              ),
            ),
            CustomContainer(
              width: Sizer().getWidth(28),
              height: Sizer().getWidth(28),
              topMargin: 0,
              onPressed: () {},
              borderRadius: 4.sp,
              color: theme.backgroundColor3,
              borderColor: theme.backgroundColor2,
              paddingSize: 0,
              child: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.black,
                size: 14.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
