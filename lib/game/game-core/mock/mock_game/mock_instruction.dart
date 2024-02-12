import 'dart:convert';

import 'package:crossworduel/core/exception/config_exception.dart';
import 'package:crossworduel/core/extension/map_error_extension.dart';

///The childs of this abstract class will hold data
///[InsD] - this is shortcut for all childs
/// [objectMap = {"status": 'SOME_STATUS', "data": {...}}]
abstract class MockInstructionData {
  final Map? _objectMap; // This hold only instruction data only
  final String _status;
  MockInstructionData(String status, Map? objectMap)
      : _objectMap = objectMap,
        _status = status;

  String get status => _status;
  Map? get objectMap => _objectMap;
  @override
  String toString() {
    return '($_status) - $objectMap';
  }
}

class MockInstructionMapper {
  static final Map<String, MockInstructionData Function(Map objectMap)>
      _generalInstructions = {MoveMockInsD.insStatus: MoveMockInsD.parseMap};

  /// Instruction List which will be availible after merging
  /// default instructions with provided instructions
  final Map<String, MockInstructionData Function(Map objectMap)> _instructions;

  MockInstructionMapper() : _instructions = {..._generalInstructions};

  MockInstructionData parse(String jsonString) {
    final Map objectMap = json.decode(jsonString) as Map;
    return mapping(objectMap);
  }

  MockInstructionData mapping(Map objectMap) {
    if (!objectMap.containsKey('status') || !objectMap.containsKey('data')) {
      throw ParsingExceptionInstr(
          objectMap: {'status or data missing': objectMap});
    } else if (!_instructions.containsKey(objectMap.getValueSafely('status'))) {
      throw MissingExceptionInstr(
          objectMap: {'NOT identified instr': objectMap});
    } else {
      Map inputRow;

      /// All [Mock] as parsing object except only [Map]
      /// if our data is [List] we will modify it to fit into the [Mock]
      if (objectMap.getValueSafely('data') is Map) {
        inputRow = objectMap.getValueSafely('data');
      } else {
        inputRow = {'items': objectMap.getValueSafely('data')};
      }
      final MockInstructionData instr =
          _instructions[objectMap.getValueSafely('status')]!(inputRow);

      return instr;
    }
  }
}

class MoveMockInsD extends MockInstructionData {
  static const String insStatus = 'KEYBOARD_TAP';
  final int correctCnt;

  MoveMockInsD({required Map objectMap, required this.correctCnt})
      : super(insStatus, objectMap);

  factory MoveMockInsD.parseMap(Map objectMap) {
    return MoveMockInsD(
        objectMap: objectMap,
        correctCnt: objectMap.getValueSafely('correctCnt'));
  }
}
