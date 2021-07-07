import 'dart:ffi';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateAssistant {
  DateTime gDate = DateTime.now();

  String gNowDateString = '';
  static String getTodayString() {
    initializeDateFormatting('ja');

    return DateFormat.yMMM('ja').format(DateTime.now()).toString();
  }

  void updateNowDate(String newDate) {
    gNowDateString = newDate;
  }
}
