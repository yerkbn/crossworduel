import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/crossword/domain/entities/span_entity.dart';
import 'package:crossworduel/features/crossword/presentation/bloc/crossword_create/crossword_create_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CrosswordSpanCluesWidget extends StatelessWidget {
  CrosswordSpanCluesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor2,
      body: Padding(
          padding:
              EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h, bottom: 8.h),
          child: SingleChildScrollView(
            child: BlocBuilder<CrosswordCreateCubit, CrosswordCreateState>(
              bloc: globalSL<CrosswordCreateCubit>(),
              builder: (_, CrosswordCreateState state) {
                return Column(
                  children: state.crosswordEntity.spans
                      .map((SpanEntity span) =>
                          _ClueInputWidget(spanEntity: span, index: 1))
                      .toList(),
                );
              },
            ),
          )),
    );
  }
}

class _ClueInputWidget extends StatelessWidget {
  final SpanEntity spanEntity;
  final int index;

  _ClueInputWidget({
    required this.spanEntity,
    required this.index,
  });

  // final TextEditingController _controller = TextEditingController();

  void _validateInput(String input) {
    List<String> words = input.trim().split(RegExp(r'\s+'));
    if (words.length < 5 || words.length > 15) {
      //   setState(() {
      //     _errorText = 'Input must be between 5 to 15 words';
      //   });
      // } else {
      //   setState(() {
      //     _errorText = null;
      //   });
    }
  }

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("#$index  ${spanEntity.answer}", style: theme.headline2),
        TextField(
          // controller: _controller,
          decoration: InputDecoration(
            // errorText: widget.isError ? "v1.util.this_field_is_required".tr() : "",
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
          style: TextStyle(
            color: theme.textColor2,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
          maxLines: 3,
          minLines: 1,
          onChanged: _validateInput,
        ),
        Divider(
          color: theme.backgroundColor3,
          thickness: .5,
        ),
      ],
    );
  }
}
