import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/appbar/main_app_bar.dart';
import 'package:crossworduel/core/design-system/bottom-sheet/custom_modal_bottom_sheet.dart';
import 'package:crossworduel/core/design-system/button/custom_button.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/design-system/page_switcher/custom_page_switcher.dart';
import 'package:crossworduel/core/design-system/page_switcher/switch_data.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/crossword/presentation/bloc/category/category_bloc.dart';
import 'package:crossworduel/features/crossword/presentation/data/main_switch_data.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword_widgets/crosswords_container_widget.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword_bottom_sheet/support_bottom_sheet.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword_widgets/crosswords_filter_widget.dart';
import 'package:crossworduel/features/unauth/presentation/bloc/auth/auth_bloc.dart';
import 'package:crossworduel/gen/assets.gen.dart';
import 'package:crossworduel/navigation/auth_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Scaffold(
        appBar: MainAppBar(withBack: false),
        backgroundColor: theme.backgroundColor2,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _getFloating,
        body: BlocBuilder<AuthBloc, AuthState>(
          bloc: globalSL(),
          builder: (context, state) {
            if (state is AuthenticatedAuthState) {
              return Column(
                children: [
                  _getHeader,
                  CrosswordsContainerWidget(
                    pageController: _pageController,
                    userId: state.me.id,
                  ),
                ],
              );
            }
            return 0.ph;
          },
        ));
  }

  Widget get _getHeader {
    return CustomContainer(
        topMargin: 0,
        borderRadius: 0,
        paddingVertical: 0,
        child: Column(
          children: [
            12.ph,
            BlocBuilder<CategoryBloc, CategoryState>(
                bloc: globalSL.get<CategoryBloc>(),
                builder: (_, CategoryState state) {
                  return CustomPageSwitcher(
                    items: MainSwitchData.getCategories(),
                    selectedValue: state.getCategory,
                    onSelected: (SwitchData switchData) {
                      _pageController.animateToPage(
                        switchData.order,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.fastOutSlowIn,
                      );
                    },
                  );
                }),
            16.ph,
            CrosswordsFilterWidget(),
            8.ph,
          ],
        ));
  }

  Widget get _getFloating {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomButton.h2(
          title: "SUPPORT",
          width: 132.w,
          onPressed: () {
            showCustomModalBottomSheet(context, SupportBottomSheet());
          },
          child: Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: Assets.icons.support.image(height: 24.h),
          ),
        ),
        CustomButton.h2(
          title: "CREATE",
          width: 132.w,
          onPressed: () {
            globalSL<AuthNavigation>().globalRouter.push(AuthNavigation.create);
          },
          child: Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: Assets.icons.pen.image(height: 22.h),
          ),
        ),
      ],
    );
  }
}
