import 'package:crossworduel/features/profile/domain/entities/score_entity.dart';
import 'package:equatable/equatable.dart';

class MeEntity extends Equatable {
  final String id;
  final String token;
  final String email;
  final String username;
  final String avatar;
  final ScoreEntity score;

  const MeEntity({
    required this.id,
    required this.token,
    required this.username,
    required this.email,
    required this.avatar,
    required this.score,
  });

  factory MeEntity.init() {
    return MeEntity(
        id: "0",
        token: "",
        username: "@itsme",
        email: "itsme@gmail.com",
        avatar:
            "https://pics.craiyon.com/2023-08-02/7a951cac85bd4aa2b0e70dbaabb8404e.webp",
        score: ScoreEntity(heart: 0, strike: 0, point: 1000));
  }

  MeEntity copyWith({
    String? username,
    String? telnumber,
    String? avatar,
    ScoreEntity? score,
  }) {
    return MeEntity(
      id: id,
      token: token,
      email: email,
      username: username ?? this.username,
      avatar: avatar ?? this.avatar,
      score: score ?? this.score,
    );
  }

  String get getToken => token;

  @override
  List<Object?> get props => [id, token, username, email, avatar, score];
}
