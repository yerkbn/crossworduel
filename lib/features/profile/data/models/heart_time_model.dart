import 'package:json_annotation/json_annotation.dart';
import 'package:crossworduel/features/profile/domain/entities/heart_time_entity.dart';
part 'heart_time_model.g.dart';

@JsonSerializable(includeIfNull: true)
class HeartTimeModel extends HeartTimeEntity {
  const HeartTimeModel({
    required super.fullAt,
    required super.secondsTillFull,
  });

  factory HeartTimeModel.fromEntity(HeartTimeEntity entity) {
    return HeartTimeModel(
      fullAt: entity.fullAt,
      secondsTillFull: entity.secondsTillFull,
    );
  }

  factory HeartTimeModel.fromJson(Map<String, dynamic> json) =>
      _$HeartTimeModelFromJson(json);

  Map<String, dynamic> toJson() => _$HeartTimeModelToJson(this);
}
