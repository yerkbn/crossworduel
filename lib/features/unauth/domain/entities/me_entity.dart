import 'package:crossworduel/core/extension/map_error_extension.dart';
import 'package:crossworduel/core/normalizer/normalizer.dart';
import 'package:crossworduel/features/profile/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MeEntity extends Equatable with Normalizer {
  final String id;
  final String email;
  final String fullname;
  final String avatar;

  const MeEntity({
    required this.id,
    required this.fullname,
    required this.email,
    required this.avatar,
  });

  factory MeEntity.init() {
    return MeEntity(
        id: "0",
        fullname: "",
        email: "itsme@gmail.com",
        avatar:
            "https://pics.craiyon.com/2023-08-02/7a951cac85bd4aa2b0e70dbaabb8404e.webp");
  }

  MeEntity copyWith() {
    return MeEntity(id: id, fullname: fullname, email: email, avatar: avatar);
  }

  String getUsername({int length = 9}) {
    int atIndex = email.indexOf('@');
    if (atIndex == -1) {
      return normalizeString(email, maxLength: length);
    }
    return normalizeString(email.substring(0, atIndex), maxLength: length);
  }

  factory MeEntity.fromUser(User user) => MeEntity(
        id: user.id,
        fullname: user.userMetadata!.getValueSafely("full_name"),
        email: user.userMetadata!.getValueSafely("email"),
        avatar: user.userMetadata!.getValueSafely("picture"),
      );

  factory MeEntity.fromJson(Map<String, dynamic> json) => MeEntity(
        id: json.getValueSafely("id"),
        fullname: json.getValueSafely("fullname"),
        email: json.getValueSafely("email"),
        avatar: json.getValueSafely("avatar"),
      );

  UserEntity get getUser =>
      UserEntity(id: id, fullName: fullname, avatar: avatar, email: email);

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "email": email,
        "avatar": avatar,
      };

  @override
  List<Object?> get props => [id, fullname, email, avatar];
}
