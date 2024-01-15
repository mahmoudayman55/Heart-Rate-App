import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:heart_rate/use_cases/pill_reminder/custom_snack_bar.dart';
import 'package:heart_rate/use_cases/pill_reminder/date_time_formater.dart';
import 'package:heart_rate/use_cases/pill_reminder/pill_model.dart';
import 'package:weekday_selector/weekday_selector.dart';

import '../../utils/app_constants.dart';
import '../../utils/custom_button.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_text_form_field.dart';
import '../../utils/hive_repo.dart';
import '../../utils/local_notification.dart';

class PillReminderController extends GetxController {
  @override
  void onInit() {
    getAllDrugs();
    super.onInit();
  }

  final formKey = GlobalKey<FormState>();
  List<bool> selectedWeeks = List.filled(7, false);

  onSelectWeek(int day) {
    int index = day % 7;
    selectedWeeks[index] = !selectedWeeks[index];

    update();
  }

  List<Pill> allPills = [];

  getAllDrugs() async {
    allPills = pillRepo.getAllEntities();
    update();
  }

  addNewDrug(Pill pill) async {
    pillRepo.createOrUpdate(pill);
    for (int i = 0; i < 7; i++) {
      if (selectedWeeks[i]) {
        DateTime now = DateTime.now();
        DateTime scheduledDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          scheduleTime.hour,
          scheduleTime.minute,
        );

        if (now.isAfter(scheduledDateTime)) {
          scheduledDateTime = scheduledDateTime.add(const Duration(days: 1));
        }

        DateTime nextNotificationTime =
            scheduledDateTime.add(Duration(days: (i - now.weekday + 7) % 7));

        for (int j = 0; j < 5; j++) {
          await LocalNotification.showScheduledNotification(
            id: Random().nextInt(99999),
            title: "Your Drug Time ${drugNameController.text} ",
            body: drugNameController.text,
            dateTime: nextNotificationTime,
          );
          dev.log("Scheduled notification at: $nextNotificationTime");

          nextNotificationTime =
              nextNotificationTime.add(const Duration(days: 7));
        }
      }
    }
    getAllDrugs();
  }

  TextEditingController drugNameController = TextEditingController();
  final pillRepo = LocalEntityRepository(AppConstants.drugBoxName);

  addDrugDialog(BuildContext context, double width, double height) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: GetBuilder<PillReminderController>(
            builder: (c) => Form(
              key: formKey,
              child: SizedBox(
                width: width,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Text(
                      "Add new medicine",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    CustomTextFormField(
                      context: context,
                      label: "Medicine name",
                      labelColor: Colors.black,
                      color: Colors.grey.shade400,
                      controller: drugNameController,
                      validator: (value) {
                        if (drugNameController.text.isEmpty) {
                          return "this field cannot be empty";
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Week Schedule",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    WeekdaySelector(
                      selectedFillColor: CustomColors.green,
                      onChanged: (int day) {
                        onSelectWeek(day);
                      },
                      values: selectedWeeks,
                      firstDayOfWeek: 0,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          "Time:",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: Colors.black),
                        )),
                        Expanded(
                          flex: 2,
                          child: CustomButton(
                              height: height * 0.06,
                              width: width,
                              iconSize: 0.05,
                              fontWeight: FontWeight.normal,
                              onPressed: () {
                                DatePicker.showTime12hPicker(context,
                                    showTitleActions: true, onConfirm: (date) {
                                  scheduleTime = date;
                                  update();
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.en);
                              },
                              label: DateTimeFormatter.amFormat(scheduleTime),
                              useGradient: false,
                              color: CustomColors.primaryColor,
                              icon: Icons.access_time,
                              circleIcon: false),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(
                          useGradient: false,
                          height: height * 0.03,
                          width: width,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (allPills
                                  .where((element) =>
                                      element.name.toLowerCase().trim() ==
                                      drugNameController.text
                                          .toLowerCase()
                                          .trim())
                                  .isNotEmpty) {
                                customSnackBar(
                                    title: "Adding medicine field",
                                    message:
                                        "Medicine already exist with the same name",
                                    successful: false);
                                return;
                              }
                              List<int> days = [];
                              for (int i = 0; i < 7; i++) {
                                if (selectedWeeks[i]) {
                                  days.add(i);
                                }
                              }
                              addNewDrug(Pill(
                                  key: Random().nextInt(9999999).toString(),
                                  name: drugNameController.text,
                                  days: days,
                                  time: DateTimeFormatter.amFormat(
                                      scheduleTime)));
                              drugNameController.clear();
                              scheduleTime =
                                  DateTime.now().add(const Duration(hours: 1));
                              selectedWeeks = List.filled(7, false);
                              Get.back();
                            }
                          },
                          label: "Add new medicine"),
                    ),
                  ],
                ),
              ),
            ),
          ));
        });
  }

  DateTime scheduleTime = DateTime.now().add(const Duration(hours: 1));
}
