/// Parent of all Custom Exceptions
/// [ExceptionData.message] is detail message
/// [ExceptionData.where] location of the child Called
///
/// 1000 - 4000 = For server Exceptions
/// 5000 - 5999 = For Game Instruction Exceptions
/// 8000 - 8999 = For cache Exceptions
/// 9000 - 9999 = For local Exceptions
///
///
/// 9000 = Not identified ERROR
abstract class ExceptionData implements Exception {
  final Map? _objectMap; // This hold only instruction data only
  final int _status;
  final String _description; // Describe exception thrown
  final bool
      isLocal; // With this flag we can differenciate instruction is backend or from Front
  ExceptionData(
      {required int status, required String description, Map? objectMap})
      : _objectMap = objectMap,
        _status = status,
        _description = description,
        isLocal = objectMap == null;

  int get getStatusInt => _status;
  String get getStatus => _status.toString();
  Map? get objectMap => _objectMap;
  String get description => _description;

  @override
  String toString() {
    return '\n-------\n::::(IDENTIFIED) ($_status) $_description DATA = [$_objectMap] \n-------\n';
  }
}
