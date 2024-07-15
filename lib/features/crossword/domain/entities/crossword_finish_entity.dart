import 'package:crossworduel/core/extension/map_error_extension.dart';
import 'package:crossworduel/core/normalizer/normalizer.dart';
import 'package:crossworduel/features/profile/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

class CrosswordFinishEntity extends Equatable with Normalizer {
  final UserEntity user;
  final int secondsElapsed;

  CrosswordFinishEntity({required this.user, required this.secondsElapsed});

  factory CrosswordFinishEntity.fromJson(Map<String, dynamic> json) {
    return CrosswordFinishEntity(
      user: UserEntity.fromJson(json.getValueSafely("user")),
      secondsElapsed: json.getValueSafely("seconds_elapsed"),
    );
  }

  static List<CrosswordFinishEntity> parseList(List items) {
    final List<CrosswordFinishEntity> result = [];
    for (final item in items) {
      result.add(CrosswordFinishEntity.fromJson(item as Map<String, dynamic>));
    }
    return result;
  }

  String get getSecondsElapsed => secToTimeLeft(secondsElapsed);

  @override
  List<Object?> get props => [user, secondsElapsed];
}
