import 'package:crossworduel/features/profile/presentation/widgets/statistics/level_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatisticsWidget extends StatefulWidget {
  const StatisticsWidget({super.key});

  @override
  State<StatisticsWidget> createState() => _StatisticsWidgetState();
}

class _StatisticsWidgetState extends State<StatisticsWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 324.w,
      child: const LevelItemWidget(),
    );
  }
}
