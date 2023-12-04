import 'package:crossworduel/core/exception/parent_exception.dart';

/// Configuration LOCAL Exceptions start from 9000

class ConfigNotIdentifiedExcD extends ExceptionData {
  static const int status = 9001;
  static const String desc = 'Given statusCode not identified =';

  ConfigNotIdentifiedExcD({super.objectMap})
      : super(status: status, description: "$desc $objectMap");

  factory ConfigNotIdentifiedExcD.parseMap(Map objectMap) {
    return ConfigNotIdentifiedExcD(objectMap: objectMap);
  }
}

class ConfigParsingExcD extends ExceptionData {
  static const int status = 9002;
  static const String desc = 'Can not parse data object for given exception';

  ConfigParsingExcD({super.objectMap})
      : super(status: status, description: desc);

  factory ConfigParsingExcD.parseMap(Map objectMap) {
    return ConfigParsingExcD(objectMap: objectMap);
  }
}

class ConfigFormatExcD extends ExceptionData {
  static const int status = 9003;
  static const String desc = '{statusCode: _, data: _} format is faild';

  ConfigFormatExcD({super.objectMap})
      : super(status: status, description: desc);

  factory ConfigFormatExcD.parseMap(Map objectMap) {
    return ConfigFormatExcD(objectMap: objectMap);
  }
}

/// When parsing some map from backend
/// and, if  requested Key is not found
/// we throw this exception
class ParsingMapExcD extends ExceptionData {
  static const int status = 9004;
  static const String desc = 'The data with key not found';

  ParsingMapExcD({super.objectMap}) : super(status: status, description: desc);

  factory ParsingMapExcD.parseMap(Map objectMap) {
    return ParsingMapExcD(objectMap: objectMap);
  }
}

/// When instruction come from backend it will be parsed
/// to appropriate class of Instruction
/// If it fails in parsing this exception will thrown
class ParsingExceptionInstr extends ExceptionData {
  static const int status = 9005;
  static const String desc = 'Instruction failed to parse';

  ParsingExceptionInstr({super.objectMap})
      : super(status: status, description: "$desc $objectMap");

  factory ParsingExceptionInstr.parseMap(Map objectMap) {
    return ParsingExceptionInstr(objectMap: objectMap);
  }
}

/// If the instruction comming from backend has incorrect format we
/// where [status] or [pata] is misssing this exception will be called
class MissingExceptionInstr extends ExceptionData {
  static const int status = 9051;
  static const String DESC =
      'incorrect format, where [status] or [pata] is misssing';

  MissingExceptionInstr({Map? objectMap})
      : super(
            status: status,
            description: "$DESC $objectMap",
            objectMap: objectMap);

  static MissingExceptionInstr parseMap(Map objectMap) {
    return MissingExceptionInstr(objectMap: objectMap);
  }
}
