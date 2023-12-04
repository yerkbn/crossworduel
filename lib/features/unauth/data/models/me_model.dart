import 'package:crossworduel/features/profile/data/models/score_model.dart';
import 'package:crossworduel/features/unauth/domain/entities/me_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'me_model.g.dart';

@JsonSerializable(includeIfNull: true)
class MeModel extends MeEntity {
  @override
  final ScoreModel score;

  const MeModel({
    required super.id,
    required super.token,
    required super.username,
    required super.email,
    required super.avatar,
    required this.score,
  }) : super(score: score);

  factory MeModel.fromJson(Map<String, dynamic> json) =>
      _$MeModelFromJson(json);

  factory MeModel.fromEntity(MeEntity me) => MeModel(
      id: me.id,
      token: me.token,
      username: me.username,
      email: me.email,
      avatar: me.avatar,
      score: ScoreModel.fromEntity(me.score));

  Map<String, dynamic> toJson() => _$MeModelToJson(this);
}
