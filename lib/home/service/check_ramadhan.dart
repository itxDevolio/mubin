import 'package:hijri/hijri_calendar.dart';

bool isRamadhan(DateTime date) {
  var ramadhan = HijriCalendar.fromDate(date);
  return ramadhan.hMonth == 9;
}