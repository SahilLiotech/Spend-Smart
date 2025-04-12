import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionDateTimeHelper {
  static DateTime combineDateTime(String dateText, String timeText) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final selectedDate = dateFormat.parse(dateText);

    final timeParts = timeText.split(':');
    final timeOfDay = TimeOfDay(
      hour: int.parse(timeParts[0]),
      minute: int.parse(timeParts[1].split(' ')[0]),
    );

    return DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
  }

  static String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String formatTime(TimeOfDay time, BuildContext context) {
    return time.format(context);
  }
}
