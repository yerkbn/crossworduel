import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/appbar/main_app_bar.dart';
import 'package:crossworduel/core/design-system/bottom-sheet/custom_full_bottom_sheet.dart';
import 'package:crossworduel/core/design-system/button/custom_button.dart';
import 'package:crossworduel/core/design-system/container/custom_container.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/crossword/domain/entities/crossword_entity.dart';
import 'package:crossworduel/features/crossword/presentation/bloc/crossword_create/crossword_create_cubit.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword_create/crossword_grid_create_widget.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword_create/crossword_span_clues_widget.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/keyboard/keyboard_widget.dart';
import 'package:crossworduel/navigation/auth_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CrosswordCreatePage extends StatefulWidget {
  final CrosswordEntity? crosswordEntity;
  const CrosswordCreatePage({super.key, this.crosswordEntity});

  @override
  State<CrosswordCreatePage> createState() => _CrosswordCreatePageState();
}

class _CrosswordCreatePageState extends State<CrosswordCreatePage> {
  late CrosswordEntity crossword;

  @override
  void initState() {
    super.initState();
    if (widget.crosswordEntity == null) {
      crossword = CrosswordEntity.empty();
    } else {
      crossword = widget.crosswordEntity!;
    }
    globalSL<CrosswordCreateCubit>().init(crossword);
  }

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Scaffold(
      appBar: MainAppBar(withBack: true),
      backgroundColor: theme.backgroundColor2,
      body: BlocBuilder<CrosswordCreateCubit, CrosswordCreateState>(
        bloc: globalSL<CrosswordCreateCubit>(),
        builder: (_, CrosswordCreateState state) {
          return CustomContainer(
            paddingVertical: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                16.ph,
                CrosswordGridCreateWidget(crossword: state.crosswordEntity),
                16.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton.h2(
                        color: theme.redLightColor,
                        title: "CLUES 12",
                        width: 154,
                        onPressed: () {
                          Navigator.of(context).push(
                              CustomFullBottomSheet.buildRoute(
                                  child: CrosswordSpanCluesWidget(),
                                  context: context,
                                  isScrollable: false));
                        }),
                    CustomButton.h2(
                        title: "SAVE",
                        width: 154,
                        onPressed: () {
                          globalSL<AuthNavigation>().globalRouter.pop();
                        }),
                  ],
                ),
                16.ph,
                KeyboardWidget(onKeyboardTap: (String letter) {
                  globalSL<CrosswordCreateCubit>().onKeyboardTap(letter);
                }, onDelete: () {
                  globalSL<CrosswordCreateCubit>().deleteLetter();
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
