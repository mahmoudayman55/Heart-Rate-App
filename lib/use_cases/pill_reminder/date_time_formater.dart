
import 'package:intl/intl.dart';
class DateTimeFormatter{
  static String amFormat(DateTime dateTime){

    return DateFormat("hh:mm a").format(dateTime);
  }


static  String getWeekdayLetter(int index) {
    List<String> days = [ 'S','M', 'T', 'W', 'T', 'F','S' ];
    return days[index];
  }



}