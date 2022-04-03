import 'package:intl/intl.dart';

/// Class FormatDate
class FormatDate {
  /// Static function that format a given date and return a [String]
  static String getDayOfWeek(DateTime dateTime) {
    return DateFormat('EEEE, d').format(dateTime);
  }

  /// Static function that format a given date and return a [String]
  static String getJustDayOfWeek(DateTime dateTime) {
    return DateFormat('EEEE').format(dateTime);
  }
}
