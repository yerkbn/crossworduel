import 'package:equatable/equatable.dart';
import 'package:crossworduel/features/profile/domain/entities/score_entity.dart';

class UserEntity extends Equatable {
  final String id;
  final String status;
  final String email;
  final String username;
  final String avatar;
  final ScoreEntity score;

  const UserEntity({
    required this.id,
    required this.status,
    required this.username,
    required this.email,
    required this.avatar,
    required this.score,
  });

  UserEntity copyWith({
    String? username,
    String? telnumber,
    String? avatar,
  }) {
    return UserEntity(
      id: id,
      status: status,
      email: email,
      username: username ?? this.username,
      avatar: avatar ?? this.avatar,
      score: score,
    );
  }

  @override
  List<Object?> get props => [id, status, username, email, avatar, score];
}
