import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:heart_rate/use_cases/pill_reminder/drug_widget.dart';
import 'package:heart_rate/use_cases/pill_reminder/pill_reminder_controller.dart';

import 'package:sizer/sizer.dart';

import '../../utils/custom_colors.dart';

class PillReminderView extends StatelessWidget {
  const PillReminderView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

    return Sizer(builder: (context, orientation, deviceType) {
      double width = 100.w;
      double height = 100.h;
      return GetBuilder<PillReminderController>(builder: (controller) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
              onPressed: () => controller.addDrugDialog(context, width, height),
              backgroundColor: CustomColors.primaryColor,
              child:const Icon(
                Icons.add,
                color: Colors.white,
              )),
          appBar: AppBar(
            title: Text(
              "Medicine reminder",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.black),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: controller.allPills.isEmpty
                  ? Center(
                      child: Text(
                      "No data founded",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: Colors.black),
                    ))
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (c, i) {
                        return SizedBox(
                            width: width,
                            height: height * 0.2,
                            child: DrugWidget(controller.allPills[i]));
                      },
                      itemCount: controller.allPills.length),
            ),
          ),
        );
      });
    });
  }
}
