import 'package:crossworduel/core/exception/config_exception.dart';

/// This extension will be used in parsing
/// because we have to know in parsing process which
/// data is missing or etc
/// if data missing it will rise [ParsingMapExcD] exception
///
/// [placeholder] - will be used as default value if value not found
extension MapErrorExtension on Map {
  T getValueSafely<T>(String key, {T? placeholder}) {
    if (containsKey(key) && this[key] != null) {
      if (this[key] is T) {
        return this[key] as T;
      } else {
        throw ParsingMapExcD(
          objectMap: {
            "KEY": key,
            "EXPECTED_TYPE": "$T",
            "map": this,
          },
        );
      }
    }
    if (placeholder != null) return placeholder;
    throw ParsingMapExcD(objectMap: {
      "NOT_FOUND_KEY": key,
      "map": this,
    });
  }

  /// Will parse map if it is exist
  /// or return null
  T? parseOrNull<T>(String key, T Function(Map objectMap) parseMap) {
    if (containsKey(key) && this[key] != null) {
      return parseMap(this[key] as Map);
    }
    return null;
  }

  ///  Some times we have to take value from map value then
  /// we will write code like [ objectMap['key1']['key2'] ]
  /// instead of it we can write [objectMap.getNestedValueSafely(['key1', 'key2'])]
  /// this method will handle rest of its
  T getNestedValueSafely<T>(List<String> keys, {T? placeholder}) {
    if (keys.isEmpty) {
      throw ParsingMapExcD(
        objectMap: {
          "KEYS LIST IS EMPTY": keys,
          "map": this,
        },
      );
    }
    Map tempObjectMap = this;
    for (int i = 0; i < keys.length; i++) {
      final value =
          tempObjectMap.getValueSafely(keys[i], placeholder: placeholder);
      if ((i + 1) == keys.length) {
        // ignore: unnecessary_type_check
        if (value is T) {
          return value;
        } else {
          throw ParsingMapExcD(
            objectMap: {
              "KEY": keys,
              "EXPECTED_TYPE": "$T",
              "map": this,
            },
          );
        }
      } else {
        tempObjectMap = value as Map;
      }
    }
    throw ParsingMapExcD(
      objectMap: {
        "KEY NOT FOUND": keys,
        "EXPECTED_TYPE": "$T",
        "map": this,
      },
    );
  }
}
