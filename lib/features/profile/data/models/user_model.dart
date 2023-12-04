import 'package:crossworduel/features/profile/data/models/score_model.dart';
import 'package:crossworduel/features/profile/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  @override
  final ScoreModel score;

  const UserModel({
    required super.id,
    required super.username,
    required super.avatar,
    required super.email,
    required this.score,
    super.status = UserEntity.strangerStatus,
  }) : super(score: score);

  static List<UserModel> fromEntityList(List<UserEntity> items) => items
      .map<UserModel>((UserEntity entity) => UserModel.fromEntity(entity))
      .toList();

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
        id: entity.id,
        username: entity.username,
        avatar: entity.avatar,
        email: entity.email,
        status: entity.status,
        score: ScoreModel.fromEntity(entity.score));
  }
  static List<UserModel> fromJsonList(List jsons) =>
      jsons.map((e) => UserModel.fromJson(e as Map<String, dynamic>)).toList();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
