import 'package:crossworduel/features/profile/domain/entities/score_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'score_model.g.dart';

@JsonSerializable(includeIfNull: true)
class ScoreModel extends ScoreEntity {
  const ScoreModel({
    required super.heart,
    required super.strike,
    required super.point,
  });

  factory ScoreModel.fromEntity(ScoreEntity entity) {
    return ScoreModel(
      heart: entity.heart,
      strike: entity.strike,
      point: entity.point,
    );
  }

  factory ScoreModel.fromJson(Map<String, dynamic> json) =>
      _$ScoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScoreModelToJson(this);
}
