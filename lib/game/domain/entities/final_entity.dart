import 'package:crossworduel/core/extension/map_error_extension.dart';
import 'package:crossworduel/features/profile/data/models/score_model.dart';
import 'package:crossworduel/features/profile/domain/entities/score_entity.dart';
import 'package:equatable/equatable.dart';

class FinalEntity extends Equatable {
  final String winnerId;
  final int delta;
  final ScoreEntity score;

  const FinalEntity({
    required this.winnerId,
    required this.delta,
    required this.score,
  });

  factory FinalEntity.parseMap(Map objectMap) {
    return FinalEntity(
      winnerId: objectMap.getValueSafely("winnerId"),
      delta: objectMap.getValueSafely("delta"),
      score: ScoreModel.fromJson(objectMap.getValueSafely('score')),
    );
  }

  String get getDelta {
    if (delta < 0) return "$delta";
    return "+$delta";
  }

  @override
  List<Object?> get props => [];
}
