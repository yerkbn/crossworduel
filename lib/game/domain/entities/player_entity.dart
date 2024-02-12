import 'dart:math';

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

  String get getProgressPoint => progressPoint.toString();
  String get getPoint => point.toString();

  factory PlayerEntity.parseMap(Map objectMap) {
    return PlayerEntity(
      id: objectMap.getValueSafely("id"),
      username: objectMap.getValueSafely("username"),
      avatar: objectMap.getValueSafely("avatar"),
      point: objectMap.getValueSafely("point"),
      progressPoint: objectMap.getValueSafely("progressPoint"),
    );
  }

  factory PlayerEntity.random(MeEntity me) {
    final int offset = (me.score.point * .1).round();
    List<String> names = [
      "@JohnDoe",
      "@EmilySmith",
      "@TechWizard",
      "@LunaExplorer",
      "@CodeMaster",
      "@StarGazer",
      "@SwiftNerd",
      "@QuantumCoder",
      "@ZenMinds",
      "@LunaDreamer",
      "@ByteNinj4",
      "@SolarEnthusiast",
      "@PixelGeek",
      "@CodeWalker",
      "@SkyPilot",
      "@ByteWizard",
      "@LunaByte",
      "@StarDust",
      "@ZenCoder",
      "@EchoByte",
      "@NeoPixelX",
      "@SolarGazeX",
      "@SonicFoxX",
      "@DreamSkyX",
      "@ZeroCoolX",
      "@ByteWizX",
      "@SwiftByteX",
      "@BlazeTechX",
      "@TechByteX",
      "@StarFuryX",
      "@LunaStarX",
      "@QuantumZX",
      "@ZenSwiftX",
      "@DreamNerdX",
      "@NovaByteX",
      "@SkyHawkX",
      "@PixelZenX",
      "@EchoByteX",
      "@CodeStarX",
      "@NeoNerdX",
      "@QuantumLXX",
      "@ByteHeroX",
      "@TechNovaX",
      "@StarByteX",
      "@SonicSkyX",
      "@LunaNautX",
      "@ZenZeroX",
      "@BlazeStarX",
      "@ByteGlowX",
      "@SolarZenX"
    ];
    List<String> avatars = [
      "https://pics.craiyon.com/2023-08-02/4ab731023cd74a3ab9060c691256aa4a.webp",
      "https://forkast.news/wp-content/uploads/2022/03/NFT-Avatar.png",
      "https://dl.memuplay.com/new_market/img/com.dressup.vlinder.ape.creator.avatar.maker.icon.2022-12-25-10-12-47.png",
      "https://pbs.twimg.com/media/E4LlwA9X0AMFGun.png",
      "https://pics.craiyon.com/2023-10-09/f078bab0940b4f6cb7998f16a7e9dcc3.webp",
      "https://www.ikangai.com/wp-content/uploads/2022/02/byac_1_wide.jpg",
      "https://watcher.guru/news/wp-content/uploads/2021/08/unnamed-2-1.png.webp",
      "https://www.cryptotimes.io/wp-content/uploads/2022/03/8585.jpg",
      "https://watcher.guru/news/wp-content/uploads/2021/08/unnamed-2-1.png.webp"
    ];
    Random rd = Random();
    return PlayerEntity(
        id: "2",
        avatar: avatars[rd.nextInt(avatars.length)],
        username: names[rd.nextInt(names.length)],
        point: me.score.point + rd.nextInt(offset),
        progressPoint: 0);
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

  Map<String, dynamic> toUser() => {
        "id": id,
        "username": username,
        "avatar": avatar,
        "email": "",
        "status": "strangerStatus",
        "score": {"heart": 0, "strike": 0, "point": point}
      };

  factory PlayerEntity.fromMe(MeEntity me) {
    return PlayerEntity(
      id: me.id,
      username: me.username,
      avatar: me.avatar,
      point: me.score.point,
      progressPoint: 0,
    );
  }

  static List<PlayerEntity> parseList(List items) {
    final List<PlayerEntity> result = [];
    for (final item in items) {
      result.add(PlayerEntity.parseMap(item as Map<String, dynamic>));
    }
    return result;
  }
}
