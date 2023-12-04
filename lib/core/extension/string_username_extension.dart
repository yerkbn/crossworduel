extension StringUsernameExtension on String {
  String get getUsernameAlloweddSymbols =>
      '_.AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  String get getOnlyLatin =>
      "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz";

  bool isValidUserame() {
    if (length > 30) return false;
    if (!getOnlyLatin.contains(this[0])) return false;
    for (int i = 0; i < length; i++) {
      if (!getUsernameAlloweddSymbols.contains(this[i])) {
        return false;
      }
    }
    return true;
  }
}
