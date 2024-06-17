// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryModel _$HistoryModelFromJson(Map<String, dynamic> json) => HistoryModel(
      id: json['id'] as String,
      leading: json['leading'] as String,
      meDelta: (json['meDelta'] as num).toInt(),
      opponent: UserModel.fromJson(json['opponent'] as Map<String, dynamic>),
      opponentDelta: (json['opponentDelta'] as num).toInt(),
      hasOpened: json['hasOpened'] as bool? ?? false,
    );

Map<String, dynamic> _$HistoryModelToJson(HistoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'opponentDelta': instance.opponentDelta,
      'meDelta': instance.meDelta,
      'leading': instance.leading,
      'hasOpened': instance.hasOpened,
      'opponent': instance.opponent,
    };
