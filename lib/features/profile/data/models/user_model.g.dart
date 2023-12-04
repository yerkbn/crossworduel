// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      username: json['username'] as String,
      avatar: json['avatar'] as String,
      email: json['email'] as String,
      score: ScoreModel.fromJson(json['score'] as Map<String, dynamic>),
      status: json['status'] as String? ?? UserEntity.strangerStatus,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'avatar': instance.avatar,
      'email': instance.email,
      'status': instance.status,
      'score': instance.score,
    };
