import 'package:crossworduel/core/extension/map_error_extension.dart';
import 'package:crossworduel/core/normalizer/normalizer.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable with Normalizer {
  static const String strangerStatus = 'strangerStatus';
  static const String friendStatus = 'friendStatus';
  static const String reqOutStatus = 'reqOutStatus';
  static const String reqInStatus = 'reqInStatus';

  final String id;
  final String fullName;
  final String avatar;
  final String email;

  const UserEntity({
    required this.id,
    required this.fullName,
    required this.avatar,
    required this.email,
  });

  String getUsername({int length = 9}) {
    int atIndex = email.indexOf('@');
    if (atIndex == -1) {
      return normalizeString(email, maxLength: length);
    }
    return normalizeString(email.substring(0, atIndex), maxLength: length);
  }

  factory UserEntity.empty() {
    return UserEntity(id: "", fullName: "", avatar: "", email: "");
  }

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json.getValueSafely("id"),
      fullName: json.getValueSafely("full_name"),
      avatar: json.getValueSafely("avatar_url"),
      email: json.getValueSafely("email"),
    );
  }

  @override
  List<Object?> get props => [id, email, avatar, email];
}
