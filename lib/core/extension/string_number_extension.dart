extension StringNumberExtension on String {
  String get getClearNumber {
    return replaceAll(RegExp(r"\s+"), "");
  }
}
