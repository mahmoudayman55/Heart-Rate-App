import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'package:sizer/sizer.dart';

import '../../utils/custom_colors.dart';
import 'not_allowed_food_controller.dart';

class NotAllowedFoodView extends StatelessWidget {
  const NotAllowedFoodView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

    return Sizer(builder: (context, orientation, deviceType) {
      double width = 100.w;
      double height = 100.h;
      return GetBuilder<NotAllowedFoodController>(builder: (controller) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
              onPressed: () => controller.addFoodDialog(context, width, height),
              backgroundColor: CustomColors.primaryColor,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              )),
          appBar: AppBar(
            title: Text(
              "Not Allowed Foods",
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
              child: controller.notAllowedFood.isEmpty
                  ? Center(
                      child: Text(
                      "No data founded",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: Colors.black),
                    ))
                  : SingleChildScrollView(
                      child: DataTable(
                        columnSpacing: width / 4.3,
                        headingRowHeight: 0,
                        headingRowColor: MaterialStateColor.resolveWith(
                            (states) => Colors.transparent),
                        columns: [
                          DataColumn(
                              label: SizedBox(
                            width: width / 2,
                            child: Text(
                              '                    ',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          )),
                          DataColumn(
                              label: Text(
                            '',
                            style: Theme.of(context).textTheme.headlineMedium,
                          )),
                        ],
                        rows: controller.notAllowedFood
                            .asMap()
                            .entries
                            .map((entry) {
                          final index = entry.key;
                          final food = entry.value;
                          final isOddRow = index % 2 == 1;
                          final rowColor =
                              isOddRow ? Colors.grey.shade300 : Colors.white;
                          return DataRow(
                            color: MaterialStateProperty.resolveWith<Color>(
                                (states) => rowColor),
                            cells: [
                              DataCell(
                                SizedBox(
                                  width: width / 2,
                                  child: Text(
                                    food.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                              ),
                              DataCell(
                                InkWell(
                                  onTap: () => controller.removeFood(food.key),
                                  child: Text(
                                    "Remove",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: Colors.red),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
            ),
          ),
        );
      });
    });
  }
}
