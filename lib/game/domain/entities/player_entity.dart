import 'package:crossworduel/core/extension/map_error_extension.dart';
import 'package:crossworduel/core/normalizer/normalizer.dart';
import 'package:crossworduel/features/unauth/domain/entities/me_entity.dart';

/// It is state because it is can not be rewriten because it holds keys
/// and animations and so on that is why it will just hold [PlayerData] as
/// data holder
///
/// and state will store some basic info
class PlayerEntity with Normalizer {
  final String id;
  final String username;
  final String avatar;
  final int point;
  final int progressPoint;

  PlayerEntity({
    required this.id,
    required this.avatar,
    required this.username,
    required this.point,
    required this.progressPoint,
  });

  factory PlayerEntity.parseMap(Map objectMap) {
    return PlayerEntity(
      id: objectMap.getValueSafely("id"),
      username: objectMap.getValueSafely("username"),
      avatar: objectMap.getValueSafely("avatar"),
      point: objectMap.getValueSafely("point"),
      progressPoint: objectMap.getValueSafely("progressPoint"),
    );
  }

  PlayerEntity copyWith({int? point, int? progressPoint}) {
    return PlayerEntity(
      id: id,
      username: username,
      avatar: avatar,
      point: point ?? this.point,
      progressPoint: progressPoint ?? this.progressPoint,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "avatar": avatar,
        "point": point,
        "progressPoint": progressPoint
      };

  factory PlayerEntity.fromMe(MeEntity me) {
    return PlayerEntity(
      id: me.id,
      username: me.username,
      avatar: me.avatar,
      point: 0,
      progressPoint: 0,
    );
  }

  String get getProgressPoint => progressPoint.toString();

  static List<PlayerEntity> parseList(List items) {
    final List<PlayerEntity> result = [];
    for (final item in items) {
      result.add(PlayerEntity.parseMap(item as Map<String, dynamic>));
    }
    return result;
  }
}
