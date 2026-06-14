import 'package:intl/intl.dart';


 dateFormate(DateTime date){
return DateFormat('yMMMd').format(date);
}
timeFormate(DateTime time){
 return DateFormat('hh:mm a').format(time);
}