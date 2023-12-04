// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScoreModel _$ScoreModelFromJson(Map<String, dynamic> json) => ScoreModel(
      heart: json['heart'] as int,
      strike: json['strike'] as int,
      point: json['point'] as int,
    );

Map<String, dynamic> _$ScoreModelToJson(ScoreModel instance) =>
    <String, dynamic>{
      'heart': instance.heart,
      'strike': instance.strike,
      'point': instance.point,
    };
