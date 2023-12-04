import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crossworduel/config/ui/custom_theme_extension.dart';

class LoadingAppBarRight extends StatelessWidget {
  final bool isLoading;
  const LoadingAppBarRight({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return isLoading
        ? Text('Sync...',
            style:
                theme.headline2.copyWith(fontSize: 12.h, color: Colors.white))
        : const SizedBox();
  }
}
