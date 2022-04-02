import 'package:intl/intl.dart';

class FormatDate {
  static String getDayOfWeek(DateTime dateTime) {
    return DateFormat('EEEE, d').format(dateTime).toString();
  }

  static String getJustDayOfWeek(DateTime dateTime) {
    return DateFormat('EEEE').format(dateTime).toString();
  }
}
