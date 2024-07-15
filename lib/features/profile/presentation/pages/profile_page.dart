import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/appbar/main_app_bar.dart';
import 'package:crossworduel/core/design-system/button/custom_button.dart';
import 'package:crossworduel/core/design-system/image/custom_image.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/core/local-pub/fetcher/fetcher.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/crossword/domain/entities/crossword_entity.dart';
import 'package:crossworduel/features/crossword/domain/usecases/get_crosswords_usecase.dart';
import 'package:crossworduel/features/crossword/presentation/bloc/crosswords_filter/crosswords_filter_cubit.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword_widgets/crossword_container_widget.dart';
import 'package:crossworduel/features/profile/domain/entities/user_entity.dart';
import 'package:crossworduel/features/unauth/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatefulWidget {
  final UserEntity userEntity;
  const ProfilePage({super.key, required this.userEntity});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final Fetcher<List<CrosswordEntity>> _fetcher;

  @override
  void initState() {
    super.initState();
    _fetcher = Fetcher<List<CrosswordEntity>>(
      fetcherUseCase: globalSL<GetCrosswordsUsecase>(),
      buildSuccess: buildSuccess,
      initalParams: GetCrosswordsParams(
          type: CrosswordsTypeEnum.Profile,
          userId: widget.userEntity.id,
          filterEntity: globalSL<CrosswordsFilterCubit>().state),
    );
    _fetcher.fetch();
  }

  Widget buildSuccess(List<CrosswordEntity> items) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            for (CrosswordEntity item in items)
              CrosswordContainerWidget(crosswordEntity: item),
            54.ph,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Scaffold(
      appBar: MainAppBar(
        withBack: true,
        isProfileNavigationEnabled: false,
      ),
      backgroundColor: theme.backgroundColor2,
      body: BlocBuilder<AuthBloc, AuthState>(
        bloc: globalSL<AuthBloc>(),
        builder: (context, state) {
          if (state is AuthenticatedAuthState) {
            UserEntity user = widget.userEntity;
            return Column(
              children: [
                24.ph,
                CustomImageWidget(
                  width: 64.h,
                  height: 64.h,
                  url: user.avatar,
                  borderRadius: 6.h,
                ),
                6.ph,
                Text(
                  user.getUsername(),
                  style: theme.headline1,
                ),
                if (state.me.getUser.id == user.id)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Center(
                      child: CustomButton.h2(
                          width: 164,
                          title: "Log out",
                          color: theme.backgroundColor4,
                          onPressed: () {
                            globalSL<AuthBloc>().signout();
                          }),
                    ),
                  ),
                Divider(
                  color: theme.backgroundColor3,
                ),
                Expanded(child: _fetcher.build(context))
              ],
            );
          }
          return 0.ph;
        },
      ),
    );
  }
}
