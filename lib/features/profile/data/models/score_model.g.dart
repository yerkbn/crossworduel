// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScoreModel _$ScoreModelFromJson(Map<String, dynamic> json) => ScoreModel(
      heart: (json['heart'] as num).toInt(),
      strike: (json['strike'] as num).toInt(),
      point: (json['point'] as num).toInt(),
    );

Map<String, dynamic> _$ScoreModelToJson(ScoreModel instance) =>
    <String, dynamic>{
      'heart': instance.heart,
      'strike': instance.strike,
      'point': instance.point,
    };
