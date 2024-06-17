/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsDictGen {
  const $AssetsDictGen();

  /// File path: assets/dict/crosswords.json
  String get crosswords => 'assets/dict/crosswords.json';

  /// File path: assets/dict/patterns.json
  String get patterns => 'assets/dict/patterns.json';

  /// File path: assets/dict/words.json
  String get words => 'assets/dict/words.json';

  /// List of all assets
  List<String> get values => [crosswords, patterns, words];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/SUPPORT.png
  AssetGenImage get support => const AssetGenImage('assets/icons/SUPPORT.png');

  /// File path: assets/icons/apple.png
  AssetGenImage get apple => const AssetGenImage('assets/icons/apple.png');

  /// File path: assets/icons/en.png
  AssetGenImage get en => const AssetGenImage('assets/icons/en.png');

  /// File path: assets/icons/fire.png
  AssetGenImage get fire => const AssetGenImage('assets/icons/fire.png');

  /// File path: assets/icons/folder.png
  AssetGenImage get folder => const AssetGenImage('assets/icons/folder.png');

  /// File path: assets/icons/google.png
  AssetGenImage get google => const AssetGenImage('assets/icons/google.png');

  /// File path: assets/icons/heart.png
  AssetGenImage get heart => const AssetGenImage('assets/icons/heart.png');

  /// File path: assets/icons/kz.png
  AssetGenImage get kz => const AssetGenImage('assets/icons/kz.png');

  /// File path: assets/icons/light.png
  AssetGenImage get light => const AssetGenImage('assets/icons/light.png');

  /// File path: assets/icons/order.png
  AssetGenImage get order => const AssetGenImage('assets/icons/order.png');

  /// File path: assets/icons/pen.png
  AssetGenImage get pen => const AssetGenImage('assets/icons/pen.png');

  /// File path: assets/icons/people.png
  AssetGenImage get people => const AssetGenImage('assets/icons/people.png');

  /// File path: assets/icons/star.png
  AssetGenImage get star => const AssetGenImage('assets/icons/star.png');

  /// File path: assets/icons/timer.png
  AssetGenImage get timer => const AssetGenImage('assets/icons/timer.png');

  /// File path: assets/icons/world.png
  AssetGenImage get world => const AssetGenImage('assets/icons/world.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        support,
        apple,
        en,
        fire,
        folder,
        google,
        heart,
        kz,
        light,
        order,
        pen,
        people,
        star,
        timer,
        world
      ];
}

class $AssetsImageGen {
  const $AssetsImageGen();

  /// File path: assets/image/background.png
  AssetGenImage get background =>
      const AssetGenImage('assets/image/background.png');

  /// File path: assets/image/go.png
  AssetGenImage get go => const AssetGenImage('assets/image/go.png');

  /// File path: assets/image/icon.png
  AssetGenImage get icon => const AssetGenImage('assets/image/icon.png');

  /// File path: assets/image/left_loading.png
  AssetGenImage get leftLoading =>
      const AssetGenImage('assets/image/left_loading.png');

  /// File path: assets/image/right_loading.png
  AssetGenImage get rightLoading =>
      const AssetGenImage('assets/image/right_loading.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [background, go, icon, leftLoading, rightLoading];
}

class Assets {
  Assets._();

  static const $AssetsDictGen dict = $AssetsDictGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImageGen image = $AssetsImageGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size = null});

  final String _assetName;

  final Size? size;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
