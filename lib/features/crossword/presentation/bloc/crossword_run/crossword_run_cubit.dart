import 'package:bloc/bloc.dart';
import 'package:crossworduel/features/crossword/domain/entities/crossword_entity.dart';
import 'package:crossworduel/features/crossword/domain/entities/point_entity.dart';
import 'package:equatable/equatable.dart';

part 'crossword_run_state.dart';

class CrosswordRunCubit extends Cubit<CrosswordRunState> {
  late CrosswordEntity _crossword;
  CrosswordRunCubit()
      : super(CrosswordRunState(crosswordEntity: CrosswordEntity.empty()));

  void init(CrosswordEntity crossword) {
    _crossword = crossword;
    if (_crossword.spans.isNotEmpty) {
      _crossword =
          _crossword.setActiveCell(point: _crossword.spans.first.point);
    }
    emit(CrosswordRunState(crosswordEntity: _crossword));
  }

  void onCellTap(PointEntity point) {
    _crossword = _crossword.setActiveCell(point: point);
    emit(CrosswordRunState(crosswordEntity: _crossword));
  }

  void onKeyboardTap(String letter) {
    _crossword = _crossword.setLetter(letter);
    emit(CrosswordRunState(crosswordEntity: _crossword));
  }

  void deleteLetter() {
    _crossword = _crossword.deleteLetter();
    emit(CrosswordRunState(crosswordEntity: _crossword));
  }

  void nextPrev(bool isNext) {
    _crossword = _crossword.nextPrev(isNext: isNext);
    emit(CrosswordRunState(crosswordEntity: _crossword));
  }
}
