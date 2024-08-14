import 'package:crossworduel/core/design-system/button/custom_button.dart';
import 'package:crossworduel/core/extension/sizedbox_extension.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/crossword/domain/entities/cell_entity.dart';
import 'package:crossworduel/features/crossword/presentation/bloc/crossword_generate/crossword_generate_cubit.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/crossword_run/cell_widget.dart';
import 'package:crossworduel/features/crossword/presentation/widgets/keyboard/keyboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddAnswerWidget extends StatefulWidget {
  const AddAnswerWidget({super.key});

  @override
  State<AddAnswerWidget> createState() => _AddAnswerWidgetState();
}

class _AddAnswerWidgetState extends State<AddAnswerWidget> {
  List<String> items = [];

  _onKeyboardTap(String letter) {
    if (items.length < 9) {
      setState(() {
        items.add(letter);
      });
    }
  }

  _onDelete() {
    setState(() {
      items.removeLast();
    });
  }

  _onCreate() {
    if (items.length > 1) {
      globalSL<CrosswordGenerateCubit>().add(items.join());
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (String item in items)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: CellWidget(cell: CellEntity.init(item)),
                ),
            ],
          ),
          16.ph,
          KeyboardWidget(
            onKeyboardTap: _onKeyboardTap,
            onDelete: _onDelete,
          ),
          CustomButton.h2(
            title: "Add +",
            onPressed: _onCreate,
            isDisabled: items.length < 2,
          )
        ],
      ),
    );
  }
}
