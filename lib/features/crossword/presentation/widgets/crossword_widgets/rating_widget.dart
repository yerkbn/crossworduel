import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/design-system/loading/custom_loading.dart';
import 'package:crossworduel/core/local-pub/fetcher/uploader.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/crossword/domain/entities/crossword_entity.dart';
import 'package:crossworduel/features/crossword/domain/usecases/set_rating_usecase.dart';
import 'package:crossworduel/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingWidget extends StatefulWidget {
  final CrosswordEntity crosswordEntity;
  const RatingWidget({required this.crosswordEntity, super.key});

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  late Uploader<CrosswordEntity> _uploader;
  int _star = 0;

  @override
  void initState() {
    super.initState();
    _uploader = Uploader(
        useCase: globalSL<SetRatingUsecase>(), buildChild: _buildUploader);
    _star = widget.crosswordEntity.star.toInt();
  }

  Widget _buildUploader(bool isLoading) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return CustomContainer(
      paddingVertical: 4.h,
      paddingHorizantal: 8.w,
      topMargin: 0,
      borderRadius: 6.r,
      color: theme.backgroundColor3,
      borderColor: theme.backgroundColor4,
      child: SizedBox(
        height: 16.h,
        child: Center(
          child: isLoading
              ? CustomLoading(
                  color: theme.textColor1,
                  progresHeight: 12.sp,
                  padding: 0,
                  strokeWidth: 2,
                )
              : Text("SAVE", style: theme.headline3.copyWith(fontSize: 12.sp)),
        ),
      ),
      onPressed: () {
        _uploader.upload(SetRatingParams(
            star: _star, crosswordId: widget.crosswordEntity.id));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return CustomContainer(
      width: 343.w,
      color: theme.backgroundColor3,
      paddingVertical: 6.h,
      topMargin: 0,
      borderRadius: 8.r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 64.w,
            alignment: Alignment.centerLeft,
            child: Text(
              "${_star}/5",
              style: theme.headline2,
            ),
          ),
          Row(
            children: [
              for (int i = 0; i < 5; i++)
                CustomContainer(
                  topMargin: 0,
                  paddingVertical: 0,
                  paddingHorizantal: 4,
                  color: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      _star = i + 1;
                    });
                  },
                  child: Assets.icons.star.image(
                      height: 24.h,
                      color:
                          ((i + 1) <= _star) ? null : theme.backgroundColor4),
                ),
            ],
          ),
          Container(
            width: 64.w,
            alignment: Alignment.centerRight,
            child: _uploader.build(context),
          )
        ],
      ),
    );
  }
}
