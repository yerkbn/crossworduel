import 'package:equatable/equatable.dart';

class ScoreEntity extends Equatable {
  final int heart;
  final int strike;
  final int point;

  const ScoreEntity({
    required this.heart,
    required this.strike,
    required this.point,
  });

  factory ScoreEntity.empty() =>
      const ScoreEntity(heart: 0, strike: 0, point: 0);

  ScoreEntity copyWith({
    int? heart,
    int? strike,
    int? point,
  }) {
    return ScoreEntity(
      heart: heart ?? this.heart,
      strike: strike ?? this.strike,
      point: point ?? this.point,
    );
  }

  String get getPoint => "$point";
  String get getHeart => "$heart";
  String get getStrike => "$strike";

  @override
  List<Object?> get props => [strike, point, heart];
}
