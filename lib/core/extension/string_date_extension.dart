extension StringDateExtension on String {
  DateTime get toDateTime {
    return DateTime.parse(this);
  }
}
