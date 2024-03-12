import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/design-system/image/custom_image.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/features/profile/domain/entities/history_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryItem extends StatelessWidget {
  final HistoryEntity historyEntity;
  final bool isSquare;
  const HistoryItem({
    super.key,
    required this.historyEntity,
    this.isSquare = false,
  });

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return CustomContainer(
        // onPressed: () {},
        color: isSquare ? theme.backgroundColor2 : theme.backgroundColor3,
        topMargin: isSquare ? 0 : 8.h,
        paddingSize: 0,
        borderRadius: isSquare ? 0 : 12.r,
        child: Row(
          children: [
            Container(
              width: 64.w,
              height: 64.h,
              decoration: BoxDecoration(
                  borderRadius: isSquare
                      ? null
                      : BorderRadius.only(
                          topLeft: Radius.circular(12.r),
                          bottomLeft: Radius.circular(12.r),
                        ),
                  color: theme.backgroundColor4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  4.ph,
                  Text(
                    historyEntity.getLeading,
                    style: theme.headline2,
                  ),
                  4.ph,
                  // Assets.icons.heart.svg(
                  //     height: 18.h,
                  //     color: historyEntity.hasOpened
                  //         ? null
                  //         : theme.backgroundColor3)
                ],
              ),
            ),
            12.pw,
            CustomImageWidget(
              url: historyEntity.opponent.avatar,
              borderRadius: 52.h,
              width: 48.h,
              height: 48.h,
            ),
            16.pw,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                4.ph,
                Row(
                  children: [
                    Text(
                      historyEntity.opponent.score.getPoint,
                      style: theme.headline1.copyWith(fontSize: 24.h),
                    ),
                    6.pw,
                    Text(historyEntity.getOpponentDelta,
                        style: theme.headline3.copyWith(
                            color: historyEntity.opponentColor,
                            fontSize: 14.h)),
                  ],
                ),
                Text(
                  historyEntity.opponent.getUsername(length: 20),
                  style: theme.headline4.copyWith(fontSize: 14.h),
                ),
              ],
            ),
            Expanded(child: 0.pw),
            Container(
              width: 52.w,
              height: 64.h,
              decoration: BoxDecoration(
                  borderRadius: isSquare
                      ? null
                      : BorderRadius.only(
                          topRight: Radius.circular(12.r),
                          bottomRight: Radius.circular(12.r),
                        ),
                  color: theme.backgroundColor4),
              child: Center(
                child: Text(
                  historyEntity.getMeDelta,
                  style: theme.headline1
                      .copyWith(color: historyEntity.meColor, fontSize: 16.sp),
                ),
              ),
            ),
          ],
        ));
  }
}
