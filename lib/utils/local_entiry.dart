import 'package:heart_rate/use_cases/allowed_foods/food_model.dart';

import '../use_cases/pill_reminder/pill_model.dart';

abstract class LocalEntity {
  final String key;

  LocalEntity({required this.key});


  factory LocalEntity.fromJson(Type type, Map<String, dynamic> e) {
    switch (type) {
      case Food:
        return Food.fromJson(e);
      case Pill:
        return Pill.fromJson(e);
      default:
        throw Exception();
    }
  }
}