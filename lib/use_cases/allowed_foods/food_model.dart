import 'package:heart_rate/utils/local_entiry.dart';

class Food extends LocalEntity{
  String name;
  Food({required super.key, required this.name});


  factory Food.fromJson(Map<String,dynamic>map){
    return Food(key: map["key"], name: map["name"]);
  }


  toJson(){
    return {
      "key":super.key,
      "name":name,
    };

  }

}