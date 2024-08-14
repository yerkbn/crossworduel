part of 'crossword_generate_cubit.dart';

class CrosswordGenerateState extends Equatable {
  final int hintIndex;
  final List<AnswerClueEntity> hints;
  const CrosswordGenerateState({required this.hints, required this.hintIndex});

  factory CrosswordGenerateState.init() {
    return CrosswordGenerateState(hints: [], hintIndex: -1);
  }

  CrosswordGenerateState copyWith(
      {List<AnswerClueEntity>? hints, int? hintIndex}) {
    return CrosswordGenerateState(
      hints: hints ?? this.hints,
      hintIndex: hintIndex ?? this.hintIndex,
    );
  }

  CrosswordGenerateState editHint(
      {required int index,
      required AnswerClueEntity edit(AnswerClueEntity old)}) {
    List<AnswerClueEntity> newHints = [];
    for (int i = 0; i < hints.length; i++) {
      if (index == i) {
        newHints.add(edit(hints[i]));
      } else {
        newHints.add(hints[i]);
      }
    }
    return copyWith(hints: newHints);
  }

  CrosswordGenerateState removeAtIndex() {
    List<AnswerClueEntity> newHints = [];
    for (int i = 0; i < hints.length; i++) {
      if (i != hintIndex) {
        newHints.add(hints[i]);
      }
    }
    return copyWith(hintIndex: newHints.isEmpty ? -1 : 0, hints: newHints);
  }

  List<String> get getWords => hints.map((e) => e.answer).toList();

  @override
  List<Object> get props => [hints, hintIndex];
}
