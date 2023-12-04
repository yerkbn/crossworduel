import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/core/local-pub/fetcher/fetcher.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/profile/domain/entities/notification_entity.dart';
import 'package:crossworduel/features/profile/domain/usecases/get_notification_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late final Fetcher<List<NotificationEntity>> _fetcher;

  @override
  void initState() {
    _fetcher = Fetcher<List<NotificationEntity>>(
      fetcherUseCase: globalSL<GetNotificationUsecase>(),
      buildSuccess: _buildSuccess,
    );
    _fetcher.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _fetcher.build(context),
    );
  }

  Widget _buildSuccess(List<NotificationEntity> items) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    if (items.isEmpty) return onEmpty;
    return SingleChildScrollView(
        child: Column(
      children: [
        for (final NotificationEntity item in items)
          ListTile(
            title: Text(
              item.title,
              style: theme.headline1,
            ),
            subtitle: Text(
              item.body,
              style: theme.headline3,
            ),
          ),
      ],
    ));
  }

  Widget get onEmpty {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            54.ph,
            Icon(
              Icons.emoji_people,
              color: Colors.white,
              size: 42.h,
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              "Қазірге еш нәрсе жоқ!",
              textAlign: TextAlign.center,
              style: theme.headline2,
            ),
          ],
        ),
      ),
    );
  }
}
