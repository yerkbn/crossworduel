// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'heart_time_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeartTimeModel _$HeartTimeModelFromJson(Map<String, dynamic> json) =>
    HeartTimeModel(
      fullAt: json['fullAt'] as String,
      secondsTillFull: (json['secondsTillFull'] as num).toInt(),
    );

Map<String, dynamic> _$HeartTimeModelToJson(HeartTimeModel instance) =>
    <String, dynamic>{
      'secondsTillFull': instance.secondsTillFull,
      'fullAt': instance.fullAt,
    };
