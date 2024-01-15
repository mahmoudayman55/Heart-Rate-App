import 'package:heart_rate/utils/local_entiry.dart';

class Pill extends LocalEntity{
  String name;
  String? time;
  Pill({required super.key, required this.name, required this.days,required this.time});
List<int> days;

  factory Pill.fromJson(Map<String,dynamic>map){
    return Pill(key: map["key"], name: map["name"], days: List<int>.from(map["days"]), time: map["time"]??"not set");
  }


  toJson(){
    return {
      "key":super.key,
      "name":name,
      "time":time??"not set",
      "days":days,
    };

  }

}