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
  PlayerEntity(
      {required this.id, required this.avatar, required this.username});

  factory PlayerEntity.parseMap(Map objectMap) {
    return PlayerEntity(
      id: objectMap.getValueSafely("id"),
      username: objectMap.getValueSafely("username"),
      avatar: objectMap.getValueSafely("avatar"),
    );
  }

  factory PlayerEntity.fromMe(MeEntity me) {
    return PlayerEntity(id: me.id, username: me.username, avatar: me.avatar);
  }

  static List<PlayerEntity> parseList(List<Map> items) {
    final List<PlayerEntity> result = [];
    for (final Map item in items) {
      result.add(PlayerEntity.parseMap(item));
    }
    return result;
  }
}
