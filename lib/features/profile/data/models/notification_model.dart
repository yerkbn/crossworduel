import 'package:crossworduel/features/profile/domain/entities/notification_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'notification_model.g.dart';

@JsonSerializable(includeIfNull: true)
class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.title,
    required super.body,
    required super.isRead,
    required super.type,
    required super.createDate,
  });

  factory NotificationModel.fromEntity(NotificationEntity entity) {
    return NotificationModel(
      id: entity.id,
      title: entity.title,
      body: entity.body,
      isRead: entity.isRead,
      type: entity.type,
      createDate: entity.createDate,
    );
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
