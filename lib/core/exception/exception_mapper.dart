import 'package:crossworduel/core/exception/config_exception.dart';
import 'package:crossworduel/core/exception/network_exception.dart';
import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:crossworduel/core/extension/map_error_extension.dart';

/// Responsible for parsing exceptions to Dart objects
class ExceptionMapper {
  /// This is default initial instructions
  /// Which will be availible in all games by default
  final Map<int, ExceptionData Function(Map objectMap)> _exceptions = {
    /// CONFIG
    ConfigNotIdentifiedExcD.status: ConfigNotIdentifiedExcD.parseMap,
    ConfigParsingExcD.status: ConfigParsingExcD.parseMap,
    ConfigFormatExcD.status: ConfigFormatExcD.parseMap,

    /// NETWORK
    NetworkFailureExcD.status: NetworkFailureExcD.parseMap,
    UnauthenticatedExcD.status: UnauthenticatedExcD.parseMap,
    BadRequestExcD.status: BadRequestExcD.parseMap,
    NotFoundExcD.status: NotFoundExcD.parseMap,
  };

  /// This should return Data if every thing is OK and statusCode == 1000
  /// or throw exception
  ///
  /// Input Map is a map of format {'statusCode': '', data: {}}
  /// and parse it and return particular instance of [ExceptionData]
  ///
  /// Exceptions:
  /// if failed to parse input throw [InstructionParsingException]
  void mapping(Map objectMap) {
    if (objectMap.containsKey('statusCode') &&
        objectMap.containsKey('result') &&
        objectMap.getValueSafely('statusCode') is int) {
      final int statausCode = objectMap.getValueSafely<int>('statusCode');
      if (_exceptions.containsKey(statausCode)) {
        if (objectMap['result'] is Map) {
          throw _exceptions[statausCode]!(objectMap['result'] as Map);
        } else {
          throw _exceptions[statausCode]!({'result': objectMap['result']});
        }
      } else {
        throw ConfigNotIdentifiedExcD(
          objectMap: {
            'statausCode': statausCode,
            'result': objectMap['result']
          },
        );
      }
    } else {
      // Format is not correct
      throw ConfigFormatExcD(objectMap: objectMap);
    }
  }
}
