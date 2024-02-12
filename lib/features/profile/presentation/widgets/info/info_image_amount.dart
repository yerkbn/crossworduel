import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/design-system/image/custom_local_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoImageAmount extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  const InfoImageAmount({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return CustomContainer(
      paddingSize: 8.h,
      onPressed: () {},
      width: 166.w,
      height: 72.h,
      color: theme.backgroundColor3,
      child: Row(
        children: [
          SizedBox(
            width: 50.w,
            child: CustomLocalImageWidget(
              image: image,
              width: 50.w,
              height: 50.w,
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.headline3
                    .copyWith(fontSize: 24.h, color: Colors.white),
              ),
              SizedBox(
                height: 6.h,
              ),
              Text(
                subTitle,
                style: theme.headline2
                    .copyWith(fontSize: 12.h, color: theme.textColor2),
              ),
            ],
          )
        ],
      ),
    );
  }
}
