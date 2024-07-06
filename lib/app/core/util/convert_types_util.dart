import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConvertTypesUtil {
  static final _dateFormat = DateFormat("dd/MM/yyyy");
  static final _hourFormat = DateFormat('hh:mm a');

  static DateTime joinDateHour(String dateText, String hourText) {
    DateTime date = convertStringToDate(dateText);
    TimeOfDay hour = convertStringToHour(hourText);

    DateTime dateHour =
        DateTime(date.year, date.month, date.day, hour.hour, hour.minute);
    return dateHour;
  }

  static String convertDateToString(DateTime date) {
    String dateString = _dateFormat.format(date);
    return dateString;
  }

  static DateTime convertStringToDate(String dateText) {
    DateTime date = _dateFormat.parse(dateText);
    return date;
  }

  static TimeOfDay convertStringToHour(String hourText) {
    TimeOfDay hour = TimeOfDay.fromDateTime(_hourFormat.parse(hourText));
    return hour;
  }

  static String convertHourToString(TimeOfDay time) {
    DateTime timeOfDayToDateTime = DateTime(2020, 1, 1, time.hour, time.minute);
    String timeString = _hourFormat.format(timeOfDayToDateTime);
    return timeString;
  }
}
