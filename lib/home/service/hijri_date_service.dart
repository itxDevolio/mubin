import 'package:hijri/hijri_calendar.dart';

String getHijriDate() {
  final hijri = HijriCalendar.now();
  return hijri.toFormat("dd MMMM yyyy");
}
