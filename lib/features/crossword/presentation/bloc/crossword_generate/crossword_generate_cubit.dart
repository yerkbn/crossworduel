import 'package:bloc/bloc.dart';
import 'package:crossworduel/features/crossword/domain/entities/answer_clue_entity.dart';
import 'package:equatable/equatable.dart';

part 'crossword_generate_state.dart';

class CrosswordGenerateCubit extends Cubit<CrosswordGenerateState> {
  CrosswordGenerateState state = CrosswordGenerateState.init();

  CrosswordGenerateCubit() : super(CrosswordGenerateState.init());

  void add(String answer) {
    AnswerClueEntity newHint = AnswerClueEntity.init(answer: answer);
    state = state.copyWith(
        hints: [...state.hints, newHint], hintIndex: state.hints.length);
    emit(state);
  }

  void editHint(
      {required int index,
      required AnswerClueEntity edit(AnswerClueEntity old)}) {
    state = state.editHint(index: index, edit: edit);
    emit(state);
  }

  void delete() {
    state = state.removeAtIndex();
    emit(state);
  }

  void setHintIndex(int index) {
    state = state.copyWith(hintIndex: index);
    emit(state.copyWith(hintIndex: index));
  }
}
