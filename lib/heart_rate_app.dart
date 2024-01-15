import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heart_rate/use_cases/splash_screen.dart';
import 'package:heart_rate/use_cases/allowed_foods/allowed_food_controller.dart';
import 'package:heart_rate/use_cases/allowed_foods/allowed_food_view.dart';
import 'package:heart_rate/use_cases/home/home_screen.dart';
import 'package:heart_rate/use_cases/ml_model/bluetooth_controller.dart';
import 'package:heart_rate/use_cases/ml_model/heart_app_view.dart';
import 'package:heart_rate/use_cases/ml_model/predection_controller.dart';
import 'package:heart_rate/use_cases/not_allowed_foods/not_allowed_food_controller.dart';
import 'package:heart_rate/use_cases/not_allowed_foods/not_allowed_food_view.dart';
import 'package:heart_rate/use_cases/pill_reminder/drugs_view.dart';
import 'package:heart_rate/use_cases/pill_reminder/pill_reminder_controller.dart';
import 'package:heart_rate/utils/app_constants.dart';
import 'package:heart_rate/utils/theme.dart';
import 'package:sizer/sizer.dart';

class HeartRateApp extends StatelessWidget {
  const HeartRateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: true,
        title: 'Heart Rate Monitor',
        theme: Themes.lightTheme,
        initialRoute: AppConstants.splashRoute,
        getPages: [
          GetPage(
            name: AppConstants.splashRoute,
            binding: BindingsBuilder(() {}),
            page: () => const SplashScreen(),
            transition: Transition.downToUp,
          ),      GetPage(
            name: AppConstants.drugRoute,
            binding: BindingsBuilder(() {
              Get.put(PillReminderController());

            }),
            page: () => const PillReminderView(),
            transition: Transition.downToUp,
          ),   GetPage(
            name: AppConstants.predictionRoute,
            binding: BindingsBuilder(() {
           Get.put(PredictionController());
            Get.put(BleController());

            }),
            page: () =>  HeartAppView(),
            transition: Transition.downToUp,
          ),     GetPage(
            name: AppConstants.homeRoute,
            binding: BindingsBuilder(() {}),
            page: () =>  const HomeView(),
            transition: Transition.downToUp,
          ),   GetPage(
            name: AppConstants.allowedFoodRoute,
            binding: BindingsBuilder(() {

              Get.put(AllowedFoodController());
            }),
            page: () =>  const AllowedFoodView(),
            transition: Transition.downToUp,
          ),  GetPage(
            name: AppConstants.notAllowedFoodRoute,
            binding: BindingsBuilder(() {

              Get.put(NotAllowedFoodController());
            }),
            page: () =>  const NotAllowedFoodView(),
            transition: Transition.downToUp,
          ),
        ],
      );
    });
  }
}
