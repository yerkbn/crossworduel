import 'dart:convert';

import 'package:crossworduel/core/exception/config_exception.dart';
import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:crossworduel/core/extension/map_error_extension.dart';
import 'package:crossworduel/game/core/crossword/entity/point_entity.dart';
import 'package:crossworduel/game/domain/entities/crossword_entity.dart';
import 'package:crossworduel/game/domain/entities/player_entity.dart';
part 'player_instruction.dart';
part 'configuration_instruction.dart';

///The childs of this abstract class will hold data
///[InsD] - this is shortcut for all childs
/// [objectMap = {"status": 'SOME_STATUS', "data": {...}}]
abstract class InstructionData {
  final Map? _objectMap; // This hold only instruction data only
  final String _status;
  final int duration; // How long this instruction will execute
  final bool
      isLocal; // With this flag we can differenciate instruction is backend or from Front
  int? order; // To check Sync between client and server
  InstructionData(String status, Map? objectMap, {this.duration = 0})
      : _objectMap = objectMap,
        _status = status,
        isLocal = objectMap == null,
        assert(duration >= 0,
            ':::: (parent_instruction) -> InstructionData: (durationn should be bigger than 0)');

  bool get isInstant => duration == 0;
  bool get isOrdered => order != null;

  String get status => _status;
  Map? get objectMap => _objectMap;
  @override
  String toString() {
    // return '($_status, local = $isLocal, duration = $duration, ordered = $isOrdered),  : $_objectMap';
    return '($_status)';
  }
}

/// Responsible for parsing instructions to Dart objects
class InstructionMapper {
  /// This is default initial instructions
  /// Which will be availible in all games by default
  static final Map<String, InstructionData Function(Map objectMap)>
      _generalInstructions = {
    // CONFIG
    RoomCreatedInsD.insStatus: RoomCreatedInsD.parseMap,
    AFKInsD.insStatus: AFKInsD.parseMap,
  };

  /// Instruction List which will be availible after merging
  /// default instructions with provided instructions
  final Map<String, InstructionData Function(Map objectMap)> _instructions;

  InstructionMapper(
      {Map<String, InstructionData Function(Map objectMap)>
          additionalInstructions = const {}})
      : _instructions = {..._generalInstructions, ...additionalInstructions};

  InstructionData parse(String jsonString) {
    final Map objectMap = json.decode(jsonString) as Map;
    return mapping(objectMap);
  }

  /// Input Map is a map of format {'status': '', data: {}}
  /// and parse it and return particular instance of [InstructionData]
  ///
  /// Exceptions:
  /// if failed to parse input throw [InstructionParsingException]
  /// if status is missing or format is incorect throe [InstructionMissingException]
  InstructionData mapping(Map objectMap) {
    if (!objectMap.containsKey('status') || !objectMap.containsKey('data')) {
      throw ParsingExceptionInstr(
          objectMap: {'status or data missing': objectMap});
    } else if (!_instructions.containsKey(objectMap.getValueSafely('status'))) {
      throw MissingExceptionInstr(
          objectMap: {'NOT identified instr': objectMap});
    } else {
      try {
        Map inputRow;

        /// All [InstructionData] as parsing object except only [Map]
        /// if our data is [List] we will modify it to fit into the [InstructionData]
        if (objectMap.getValueSafely('data') is Map) {
          inputRow = objectMap.getValueSafely('data');
        } else {
          inputRow = {'items': objectMap.getValueSafely('data')};
        }
        final InstructionData instr =
            _instructions[objectMap.getValueSafely('status')]!(inputRow);
        instr.order = objectMap.containsKey('order')
            ? objectMap.getValueSafely('order')
            : null;
        return instr;
      } catch (err) {
        if (err is ExceptionData) {
          rethrow;
        }
        rethrow;
        // throw 'Instrustion parsing error $err';
      }
    }
  }
}

abstract class ReconnectingInsD extends InstructionData {
  ReconnectingInsD(super.status, Map super.objectMap);
}
