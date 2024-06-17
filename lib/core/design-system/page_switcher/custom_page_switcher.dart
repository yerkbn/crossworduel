import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/page_switcher/switch_data.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPageSwitcher extends StatelessWidget {
  final List<SwitchData> items;
  final SwitchData selectedValue;
  final Function(SwitchData) onSelected;
  const CustomPageSwitcher({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Container(
      width: double.infinity,
      height: 30.h,
      decoration: BoxDecoration(
        color: theme.backgroundColor3,
        borderRadius: BorderRadius.circular(8.sp),
      ),
      padding: EdgeInsets.all(3.sp),
      child: Row(
        children: [
          ...items.map((e) => _buildItem(e, theme)).toList(),
        ],
      ),
    );
  }

  Widget _buildItem(SwitchData model, CustomThemeExtension theme) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onSelected(model);
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: model.value == selectedValue.value
                ? theme.backgroundColor4
                : null,
            borderRadius: BorderRadius.circular(6.sp),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  model.imagePath,
                  height: 16.h,
                ),
                6.pw,
                Text(
                  model.title,
                  style: model.value == selectedValue.value
                      ? theme.headline3.copyWith(color: Colors.white)
                      : theme.headline4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
