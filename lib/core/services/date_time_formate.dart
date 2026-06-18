import 'package:intl/intl.dart';

String dateFormate(DateTime date) {
  return DateFormat('yMMMd').format(date);
}

String timeFormate(DateTime time) {
  return DateFormat('hh:mm a').format(time);
}
