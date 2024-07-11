import 'package:crossworduel/core/extension/map_error_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MeEntity extends Equatable {
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

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "email": email,
        "avatar": avatar,
      };

  @override
  List<Object?> get props => [id, fullname, email, avatar];
}
