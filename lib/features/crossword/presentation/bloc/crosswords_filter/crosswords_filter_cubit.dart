import 'package:bloc/bloc.dart';
import 'package:crossworduel/features/crossword/domain/entities/crosswords_filter_entity.dart';

class CrosswordsFilterCubit extends Cubit<CrosswordsFilterEntity> {
  CrosswordsFilterCubit()
      : super(CrosswordsFilterEntity(
            language: LanguageEnum.en.toString(),
            difficulty: DifficultyEnum.medium.toString()));
}
