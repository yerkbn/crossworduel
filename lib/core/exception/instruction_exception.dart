import 'package:crossworduel/core/exception/parent_exception.dart';

/// When instruction come from backend it will be parsed
/// to appropriate class of Instruction
/// If it fails in parsing this exception will thrown
class InstructionParsingException extends ExceptionData {
  static const int status = 5000;
  static const String desc = 'Instruction Parsing Exception';

  InstructionParsingException({super.objectMap})
      : super(status: status, description: desc);

  factory InstructionParsingException.parseMap(Map objectMap) {
    return InstructionParsingException(objectMap: objectMap);
  }
}

/// If the instruction comming from backend has incorrect format we
/// where [status] or [data] is misssing this exception will be called
class InstructionMissingException extends ExceptionData {
  static const int status = 5001;
  static const String desc = 'Instruction Missing Exception';

  InstructionMissingException({super.objectMap})
      : super(status: status, description: desc);

  factory InstructionMissingException.parseMap(Map objectMap) {
    return InstructionMissingException(objectMap: objectMap);
  }
}

/// [InsException] exceptions thrown when parsing instructions
class ConfigurationInsException extends ExceptionData {
  static const int status = 5002;
  static const String desc = 'Configuration Ins Exception';

  ConfigurationInsException({super.objectMap})
      : super(status: status, description: desc);

  factory ConfigurationInsException.parseMap(Map objectMap) {
    return ConfigurationInsException(objectMap: objectMap);
  }
}
