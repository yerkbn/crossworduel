import 'package:crossworduel/core/exception/parent_exception.dart';

class CacheExcD extends ExceptionData {
  static const int status = 8000;
  static const String desc = 'Exception related to cache';

  CacheExcD({super.objectMap}) : super(status: status, description: desc);

  factory CacheExcD.parseMap(Map objectMap) {
    return CacheExcD(objectMap: objectMap);
  }
}
