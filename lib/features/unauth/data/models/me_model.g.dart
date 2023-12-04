// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'me_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeModel _$MeModelFromJson(Map<String, dynamic> json) => MeModel(
      id: json['id'] as String,
      token: json['token'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String,
      score: ScoreModel.fromJson(json['score'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MeModelToJson(MeModel instance) => <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'email': instance.email,
      'username': instance.username,
      'avatar': instance.avatar,
      'score': instance.score,
    };
