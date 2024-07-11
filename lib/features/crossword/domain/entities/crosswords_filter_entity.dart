import 'package:equatable/equatable.dart';

enum LanguageEnum { en, kz, ru }

enum DifficultyEnum { easy, medium, hard }

class CrosswordsFilterEntity extends Equatable {
  final String language;
  final String difficulty;

  CrosswordsFilterEntity({
    required this.language,
    required this.difficulty,
  });

  @override
  List<Object?> get props => [language, difficulty];
}
