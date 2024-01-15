import 'package:heart_rate/use_cases/pill_reminder/date_time_formater.dart';

class WeekSchedule {
int day;
DateTime time;

WeekSchedule(this.day, this.time);

toJson(){
  return {
    "day":day,
    "time":DateTimeFormatter.amFormat(time)
  };
}

factory WeekSchedule.fromJson(Map<String,dynamic>map){
  return WeekSchedule(map['day'], map['time']);
}
}