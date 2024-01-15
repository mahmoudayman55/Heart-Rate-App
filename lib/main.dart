import 'package:flutter/material.dart';
import 'package:heart_rate/heart_rate_app.dart';
import 'package:heart_rate/utils/app_constants.dart';
import 'package:heart_rate/utils/local_notification.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  await Hive.initFlutter();
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotification.init(initSchedule: true);
  await Future.delayed(const Duration(milliseconds: 300));
  await Hive.openBox<String>(AppConstants.allowedFoodBoxName);
  await Hive.openBox<String>(AppConstants.notAllowedFoodBoxName);
  await Hive.openBox<String>(AppConstants.drugBoxName);
  runApp(const HeartRateApp());
}
