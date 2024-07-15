import 'package:crossworduel/config/ui/custom_theme_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum LanguageEnum { en, kz, ru }

enum DifficultyEnum { easy, medium, hard }

class CrosswordsFilterEntity extends Equatable {
  final String language;
  final String difficulty;

  CrosswordsFilterEntity({
    required this.language,
    required this.difficulty,
  });

  factory CrosswordsFilterEntity.init() {
    return CrosswordsFilterEntity(
        language: LanguageEnum.en.name, difficulty: DifficultyEnum.medium.name);
  }

  CrosswordsFilterEntity copyWith({LanguageEnum? ln, DifficultyEnum? df}) {
    return CrosswordsFilterEntity(
      language: ln?.name ?? language,
      difficulty: df?.name ?? difficulty,
    );
  }

  static Color getLightColor(BuildContext context, String difficulty) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    if (difficulty == DifficultyEnum.easy.name) {
      return theme.greenLightColor;
    } else if (difficulty == DifficultyEnum.medium.name) {
      return theme.yellowLightColor;
    } else if (difficulty == DifficultyEnum.hard.name) {
      return theme.redLightColor;
    }
    return theme.greenLightColor;
  }

  static Color getHardColor(BuildContext context, String difficulty) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    if (difficulty == DifficultyEnum.easy.name) {
      return theme.greenHardColor;
    } else if (difficulty == DifficultyEnum.medium.name) {
      return theme.yellowHardColor;
    } else if (difficulty == DifficultyEnum.hard.name) {
      return theme.redHardColor;
    }
    return theme.greenHardColor;
  }

  @override
  List<Object?> get props => [language, difficulty];
}
