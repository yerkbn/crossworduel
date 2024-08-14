import 'package:bloc/bloc.dart';
import 'package:crossworduel/features/crossword/domain/entities/crossword_entity.dart';
import 'package:crossworduel/features/crossword/domain/entities/point_entity.dart';
import 'package:crossworduel/features/crossword/domain/entities/span_entity.dart';
import 'package:equatable/equatable.dart';

part 'crossword_create_state.dart';

class CrosswordCreateCubit extends Cubit<CrosswordCreateState> {
  late CrosswordEntity _crossword;
  CrosswordCreateCubit()
      : super(CrosswordCreateState(crosswordEntity: CrosswordEntity.empty()));

  void init(CrosswordEntity crossword) {
    _crossword = crossword;
    if (_crossword.spans.isNotEmpty) {
      _crossword =
          _crossword.setActiveCell(point: _crossword.spans.first.point);
    }
    emit(CrosswordCreateState(crosswordEntity: _crossword));
  }

  void onCellTap(PointEntity point) {
    SpanEntity? active = _crossword.getActiveSpan;
    _crossword = _crossword.normalizeSpans();
    _crossword = _crossword.createTempSpan(point: point, activeSpan: active);
    emit(CrosswordCreateState(crosswordEntity: _crossword));
  }

  void onKeyboardTap(String letter) {
    _crossword = _crossword.setLetter(letter);
    emit(CrosswordCreateState(crosswordEntity: _crossword));
  }

  void deleteLetter() {
    _crossword = _crossword.deleteLetter();
    emit(CrosswordCreateState(crosswordEntity: _crossword));
  }

  void nextPrev(bool isNext) {
    _crossword = _crossword.nextPrev(isNext: isNext);
    emit(CrosswordCreateState(crosswordEntity: _crossword));
  }
}
