import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/design-system/appbar/main_app_bar.dart';
import 'package:crossworduel/core/design-system/bottom-sheet/custom_full_bottom_sheet.dart';
import 'package:crossworduel/core/design-system/bottom-sheet/custom_modal_bottom_sheet.dart';
import 'package:crossworduel/core/design-system/button/custom_button.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/core/word_placer/crossword_words_placer.dart';
import 'package:crossworduel/features/crossword/domain/entities/answer_clue_entity.dart';
import 'package:crossworduel/features/crossword/domain/entities/span_entity.dart';
import 'package:crossworduel/features/crossword/presentation/bloc/crossword_generate/crossword_generate_cubit.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword_generate/add_answer_widget.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword_generate/generated_crossword_widget.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword_generate/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CrosswordGenerateWidget extends StatefulWidget {
  CrosswordGenerateWidget({super.key});

  @override
  State<CrosswordGenerateWidget> createState() =>
      _CrosswordGenerateWidgetState();
}

class _CrosswordGenerateWidgetState extends State<CrosswordGenerateWidget> {
  void generate(List<String> words) {
    CrosswordWordsPlacer crosswordWordsPlacer = CrosswordWordsPlacer();
    List<List<SpanEntity>> spans = crosswordWordsPlacer.solve(words);
    if (spans.isNotEmpty) {
      Navigator.of(context).push(CustomFullBottomSheet.buildRoute(
          child: GeneratedCrosswordWidget(spans: spans),
          context: context,
          isScrollable: false));
    } else {
      showCustomModalBottomSheet(
          context,
          Center(
            child:
                StatusWidget(title: "Please continue, no intersection found!"),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor2,
      appBar: MainAppBar(),
      body: BlocBuilder<CrosswordGenerateCubit, CrosswordGenerateState>(
        bloc: globalSL<CrosswordGenerateCubit>(),
        builder: (_, CrosswordGenerateState state) {
          return Column(children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
                  child: Column(
                    children: [
                      for (int i = 0; i < state.hints.length; i++)
                        _ClueInputWidget(
                          item: state.hints[i],
                          index: i,
                          isActive: state.hintIndex == i,
                        ),
                      if (state.hints.isEmpty)
                        Text("Please + Add Words!", style: theme.headline1)
                    ],
                  ),
                ),
              ),
            ),
            _buildBottomControl(state),
          ]);
        },
      ),
    );
  }

  Widget _buildBottomControl(CrosswordGenerateState state) {
    print("------------");
    for (AnswerClueEntity i in state.hints) print("ITEMS = ${i.clue}");
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    List<Widget> controlWidget = [
      CustomButton.h2(
          width: 116.w,
          title: "Generate",
          isDisabled: state.hints.length < 2,
          onPressed: () {
            generate(state.getWords);
          }),
      CustomButton.h2(
          width: 116.w,
          title: "+ Add Word",
          onPressed: () {
            showCustomModalBottomSheet(context, AddAnswerWidget());
          }),
    ];
    if (state.hintIndex != -1)
      controlWidget.add(CustomButton.h2(
          width: 42.w,
          title: "",
          color: Colors.redAccent,
          child: Icon(Icons.delete, color: Colors.white),
          onPressed: () {
            globalSL<CrosswordGenerateCubit>().delete();
          }));
    return Container(
      decoration: BoxDecoration(
          color: theme.backgroundColor2,
          border: Border(
              top: BorderSide(
            color: theme.backgroundColor4,
          ))),
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(top: 16.h, bottom: 32.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: controlWidget,
        ),
      ),
    );
  }
}

class _ClueInputWidget extends StatefulWidget {
  final AnswerClueEntity item;
  final bool isActive;
  final int index;

  _ClueInputWidget(
      {required this.item, required this.index, required this.isActive});

  @override
  State<_ClueInputWidget> createState() => _ClueInputWidgetState();
}

class _ClueInputWidgetState extends State<_ClueInputWidget> {
  static const int maxSymbol = 40;
  String? _errorText;

  void _validateInput(String input) {
    if (input.length < 5 || input.length > maxSymbol) {
      setState(() {
        _errorText = 'It should be between 5 and $maxSymbol characters.';
      });
    } else {
      setState(() {
        _errorText = null;
      });
      globalSL<CrosswordGenerateCubit>().editHint(
          index: widget.index,
          edit: (AnswerClueEntity old) => old.copyWith(clue: input));
    }
  }

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    Color color = widget.isActive ? theme.primaryColor : theme.backgroundColor3;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
            text: TextSpan(style: theme.headline2, children: [
          TextSpan(
              text: "#${widget.index + 1} ",
              style: TextStyle(color: theme.primaryColor)),
          TextSpan(
            text: " ${widget.item.answer}",
          ),
        ])),
        Container(
          // color: Colors.yellow,
          height: 34.h,
          padding: EdgeInsets.all(1),
          child: TextField(
            textInputAction: TextInputAction.done,
            // controller: _controller,
            decoration: InputDecoration(
              errorText: _errorText,
              labelText: "Clue...",
              labelStyle: TextStyle(
                color: theme.textColor2,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
              floatingLabelStyle:
                  TextStyle(color: theme.backgroundColor2, fontSize: 0),
              contentPadding: EdgeInsets.zero,
              fillColor: theme.backgroundColor2,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide.none,
              ),
            ),
            textAlign: TextAlign.left,
            onTap: () {
              globalSL<CrosswordGenerateCubit>().setHintIndex(widget.index);
            },
            style: TextStyle(
              color: theme.textColor2,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
            maxLines: 1,
            minLines: 1,
            onChanged: _validateInput,
          ),
        ),
        Divider(color: color, thickness: 1),
        8.ph
      ],
    );
  }
}
