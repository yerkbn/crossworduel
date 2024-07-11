import 'package:crossworduel/core/extension/map_error_extension.dart';
import 'package:equatable/equatable.dart';

class CrosswordEntity extends Equatable {
  final String id;
  final String created_at;
  final String user_id;
  final String title;
  final String description;
  final String language;
  final String difficulty;

  const CrosswordEntity({
    required this.id,
    required this.created_at,
    required this.user_id,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.language,
  });

  factory CrosswordEntity.fromJson(Map<String, dynamic> json) =>
      CrosswordEntity(
        id: json.getValueSafely("id"),
        created_at: json.getValueSafely("created_at"),
        user_id: json.getValueSafely("user_id"),
        title: json.getValueSafely("title"),
        description: json.getValueSafely("description"),
        difficulty: json.getValueSafely("difficulty"),
        language: json.getValueSafely("language"),
      );

  static List<CrosswordEntity> parseList(List items) {
    final List<CrosswordEntity> result = [];
    for (final item in items) {
      result.add(CrosswordEntity.fromJson(item as Map<String, dynamic>));
    }
    return result;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": created_at,
        "user_id": user_id,
        "title": title,
        "description": description,
        "difficulty": difficulty,
        "language": language,
      };

  @override
  List<Object?> get props =>
      [id, created_at, user_id, title, description, language, difficulty];
}
