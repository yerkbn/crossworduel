import 'package:bloc/bloc.dart';
import 'package:crossworduel/features/crossword/domain/entities/crosswords_filter_entity.dart';

class CrosswordsFilterCubit extends Cubit<CrosswordsFilterEntity> {
  CrosswordsFilterCubit()
      : super(CrosswordsFilterEntity(
            language: LanguageEnum.en.name,
            difficulty: DifficultyEnum.medium.name));

  void changeLanguage(LanguageEnum ln) => emit(state.copyWith(ln: ln));
  void changeDifficulty(DifficultyEnum df) => emit(state.copyWith(df: df));
  void refresh() => emit(state.copyWith());
}
