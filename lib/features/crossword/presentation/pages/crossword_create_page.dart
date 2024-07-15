import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/appbar/main_app_bar.dart';
import 'package:crossworduel/core/design-system/button/custom_button.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/features/crossword/domain/entities/crossword_entity.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword_run/crossword_grid_widget.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/keyboard/keyboard_widget.dart';
import 'package:crossworduel/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CrosswordCreatePage extends StatelessWidget {
  final CrosswordEntity crosswordEntity;
  const CrosswordCreatePage({super.key, required this.crosswordEntity});

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Scaffold(
      appBar: MainAppBar(withBack: true),
      backgroundColor: theme.backgroundColor2,
      body: CustomContainer(
        paddingVertical: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            16.ph,
            CrosswordGridWidget(crossword: crosswordEntity),
            16.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomContainer(
                  color: theme.backgroundColor3,
                  borderColor: theme.backgroundColor4,
                  paddingSize: 8,
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: theme.textColor1,
                    size: 16.h,
                  ),
                  onPressed: () {},
                ),
                CustomContainer(
                    paddingSize: 8,
                    color: theme.backgroundColor3,
                    width: 254,
                    child: Text(
                      "Lorem Ipsum is simply dummy text of the printin Ipsum has been the industry's standard dummy text ever since the 1500s",
                      textAlign: TextAlign.center,
                      style: theme.headline4
                          .copyWith(color: theme.textColor1, fontSize: 12.sp),
                    )),
                CustomContainer(
                  color: theme.backgroundColor3,
                  borderColor: theme.backgroundColor4,
                  paddingSize: 8,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: theme.textColor1,
                    size: 16.h,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            16.ph,
            CustomButton.h2(
                title: "EXTRA HINT",
                width: 184.w,
                child: Padding(
                  padding: EdgeInsets.only(right: 4.w),
                  child: Assets.icons.heart.image(height: 22.h),
                ),
                onPressed: () {}),
            16.ph,
            KeyboardWidget(),
          ],
        ),
      ),
    );
  }
}
