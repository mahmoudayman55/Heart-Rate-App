import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:heart_rate/use_cases/home/menu_button.dart';
import 'package:heart_rate/utils/app_constants.dart';

import 'package:sizer/sizer.dart';


class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

    return Scaffold(backgroundColor: Colors.indigo,body: Sizer(builder: (context, orientation, deviceType) {
      double width = 100.w;
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Heart Rate App",style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.white),),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MenuButton(
                    width: width,
                    onPressed: () => Get.toNamed(AppConstants.predictionRoute),
                    label: "Heart rate",
                    icon: Icons.monitor_heart_outlined,
                  ),
                  MenuButton(
                      width: width,
                      onPressed: () => Get.toNamed(AppConstants.drugRoute),
                      label: "Medicine reminder",
                      icon: Icons.medication,
                      color: Colors.lightBlueAccent),
                  MenuButton(
                      width: width,
                      onPressed: () => Get.toNamed(AppConstants.allowedFoodRoute),
                      label: "Allowed foods",
                      icon: Icons.fastfood,
                      color: Colors.orange),
                  MenuButton(
                      width: width,
                      onPressed: () => Get.toNamed(AppConstants.notAllowedFoodRoute),
                      label: "Not Allowed foods",
                      icon: Icons.no_food,
                      color: Colors.deepOrange),
                ],
              ),
            ],
          ),
        ),
      );
    }));
  }
}
