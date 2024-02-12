import 'package:crossworduel/core/normalizer/normalizer.dart';
import 'package:crossworduel/features/profile/domain/entities/score_entity.dart';
import 'package:crossworduel/features/unauth/domain/entities/me_entity.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable with Normalizer {
  static const String strangerStatus = 'strangerStatus';
  static const String friendStatus = 'friendStatus';
  static const String reqOutStatus = 'reqOutStatus';
  static const String reqInStatus = 'reqInStatus';

  final String id;
  final String username;
  final String avatar;
  final String email;
  final ScoreEntity score;
  final String status; // friends status

  const UserEntity({
    required this.id,
    required this.username,
    required this.avatar,
    required this.email,
    required this.score,
    required this.status,
  });

  factory UserEntity.fromMe(MeEntity me) => UserEntity(
        id: me.id,
        avatar: me.avatar,
        username: me.username,
        email: me.email,
        score: me.score,
        status: strangerStatus,
      );

  factory UserEntity.empty({String? status}) => UserEntity(
        id: "1111",
        avatar:
            "https://sm.ign.com/ign_nordic/cover/a/avatar-gen/avatar-generations_prsz.jpg",
        username: "@avatar",
        email: "",
        score: ScoreEntity.empty(),
        status: status ?? strangerStatus,
      );

  String getUsername({int length = 9}) => normalizeString(
        "$username",
        maxLength: length,
        withDots: true,
      );

  @override
  List<Object?> get props => [id, username, avatar, email, score];
}
