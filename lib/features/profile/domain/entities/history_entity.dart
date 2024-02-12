import 'package:crossworduel/core/normalizer/normalizer.dart';
import 'package:crossworduel/features/profile/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class HistoryEntity extends Equatable with Normalizer {
  final String id;
  final UserEntity opponent;
  final int opponentDelta;
  final int meDelta;
  final String leading;
  final bool hasOpened;

  const HistoryEntity({
    required this.id,
    required this.opponent,
    required this.opponentDelta,
    required this.meDelta,
    required this.leading,
    required this.hasOpened,
  });

  factory HistoryEntity.empty() {
    return HistoryEntity(
        id: "",
        opponent: UserEntity.empty(),
        opponentDelta: -10,
        meDelta: 10,
        hasOpened: false,
        leading: "RES");
  }

  Color get meColor => meDelta < 0 ? Colors.red : Colors.green;
  Color get opponentColor => opponentDelta < 0 ? Colors.red : Colors.green;

  String get getLeading => normalizeString(leading, maxLength: 3).toUpperCase();
  String get getMeDelta => meDelta < 0 ? "$meDelta" : "+$meDelta";
  String get getOpponentDelta =>
      opponentDelta < 0 ? "$opponentDelta" : "+$opponentDelta";

  @override
  List<Object?> get props => [id, opponent, opponentDelta, meDelta, leading];
}
