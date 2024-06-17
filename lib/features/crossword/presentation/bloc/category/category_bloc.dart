import 'package:crossworduel/features/crossword/presentation/data/main_switch_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(ActiveCategoryState(category: MainSwitchData.my())) {
    on<SwitchCategoryEvent>((event, emit) {
      emit(ActiveCategoryState(category: event.category));
    });
  }
}
