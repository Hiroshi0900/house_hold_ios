import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateAssistant {
  static String getTodayString() {
    initializeDateFormatting('ja');

    return DateFormat.yMMM('ja').format(DateTime.now()).toString();
  }
}
