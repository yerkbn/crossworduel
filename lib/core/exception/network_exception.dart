import 'package:crossworduel/core/exception/parent_exception.dart';

/// Network, System Exceptions start from 1000

class NetworkFailureExcD extends ExceptionData {
  static const int status = 1001;
  static const String desc = 'Network failure';

  NetworkFailureExcD({super.objectMap})
      : super(status: status, description: desc);

  factory NetworkFailureExcD.parseMap(Map objectMap) {
    return NetworkFailureExcD(objectMap: objectMap);
  }
}

class UnauthenticatedExcD extends ExceptionData {
  static const int status = 1002;
  static const String desc =
      'Unauthenticated, try to access to senssitive data';

  UnauthenticatedExcD({super.objectMap})
      : super(status: status, description: desc);

  factory UnauthenticatedExcD.parseMap(Map objectMap) {
    return UnauthenticatedExcD(objectMap: objectMap);
  }
}

/// FROM SERVER

class BadRequestExcD extends ExceptionData {
  static const int status = 2001;
  static const String desc = 'Request was incorrect';

  BadRequestExcD({super.objectMap}) : super(status: status, description: desc);

  factory BadRequestExcD.parseMap(Map objectMap) {
    return BadRequestExcD(objectMap: objectMap);
  }
}

class NotFoundExcD extends ExceptionData {
  static const int status = 2002;
  static const String desc = 'Requested item not found';

  NotFoundExcD({super.objectMap}) : super(status: status, description: desc);

  factory NotFoundExcD.parseMap(Map objectMap) {
    return NotFoundExcD(objectMap: objectMap);
  }
}
