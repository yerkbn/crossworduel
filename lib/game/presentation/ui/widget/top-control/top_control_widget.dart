import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/core/util/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopControlWidget extends StatefulWidget {
  const TopControlWidget({super.key});

  @override
  State<TopControlWidget> createState() => _TopControlWidgetState();
}

class _TopControlWidgetState extends State<TopControlWidget> {
  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Container(
      margin: EdgeInsets.only(top: Sizer().getHeight(62)),
      // color: Colors.black,
      width: Sizer().getHeight(327),
      height: Sizer().getHeight(36),
      child: Row(
        children: [
          CustomContainer(
              width: Sizer().getHeight(36),
              height: Sizer().getHeight(36),
              paddingSize: 0,
              topMargin: 0,
              borderRadius: Sizer().getSp(4),
              color: theme.backgroundColor3,
              onPressed: () {},
              child: Icon(
                Icons.close,
                color: theme.textColor1,
                size: Sizer().getSp(20),
              )),
          12.pw,
          CustomContainer(
              width: Sizer().getHeight(36),
              height: Sizer().getHeight(36),
              paddingSize: 0,
              topMargin: 0,
              borderRadius: Sizer().getSp(4),
              color: theme.backgroundColor3,
              onPressed: () {},
              child: Icon(
                Icons.record_voice_over_outlined,
                color: theme.textColor1,
                size: Sizer().getSp(20),
              )),
          12.pw,
          CustomContainer(
              width: Sizer().getHeight(36),
              height: Sizer().getHeight(36),
              paddingSize: 0,
              topMargin: 0,
              borderRadius: Sizer().getSp(4),
              color: theme.backgroundColor3,
              onPressed: () {},
              child: Icon(
                Icons.dark_mode,
                color: theme.textColor1,
                size: Sizer().getSp(20),
              )),
          12.pw,
          Text(
            "24 sec",
            style: theme.headline1.copyWith(fontSize: 18.sp),
          ),
        ],
      ),
    );
  }
}