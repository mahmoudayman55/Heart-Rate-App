import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:heart_rate/use_cases/ml_model/predection_controller.dart';
import 'package:heart_rate/use_cases/ml_model/predection_view.dart';
import 'package:sizer/sizer.dart';

import '../../utils/custom_button.dart';
import '../../utils/custom_text_form_field.dart';
import 'bluetooth_view.dart';

class HeartAppView extends StatelessWidget {
  final PredictionController predictionController =
  Get.find<PredictionController>();

   HeartAppView({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

    return
      Sizer(
        builder:(context, orientation, deviceType)  {
          double width = 100.w;
          double height = 100.h;
          return GetBuilder<PredictionController>(
            init: PredictionController(),
            builder: (controller) {
              return predictionController.baseUrl==null? Scaffold(body: Center(child:
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: controller.formKey,
                  child: SizedBox(
                    width: width,
                    child: ListView(
                      shrinkWrap: true,
                      children: [

                        CustomTextFormField(
                          context: context,
                          label: "Base url",
                          labelColor: Colors.black,
                          color: Colors.grey.shade400,
                          controller: controller.baseUrlController,
                          validator: (value) {
                            if (controller.baseUrlController.text.isEmpty) {
                              return "this field cannot be empty";
                            }
                            return null;
                          },
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomButton(
                              useGradient: false,
                              height: height * 0.03,
                              width: width,
                              onPressed: () {
                                if (controller.formKey.currentState!.validate()) {
                                  controller.  baseUrl=controller. baseUrlController.text.trim();
                                  controller. update();
                                }

                              },
                              label: "Continue"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),),):
              DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar:  AppBar(
                    title: Text(
                      "Heart rate",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: Colors.black),
                    ),
                    centerTitle: true,
                  ),
                  backgroundColor: Colors.white,
                  body: Sizer(builder: (context, orientation, deviceType) {
                    double width = 100.w;
                    return SafeArea(
                      child: SizedBox(width: width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Add tabs here
                            Container(
                              height: 5.0.h,width: width,alignment: Alignment.center,
                              child: const TabBar(
                                tabs: [
                                  Tab(text: 'Bluetooth'),
                                  Tab(text: 'Prediction'),
                                ],
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  BluetoothView(),
                                  PredictionView(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              );
            }
          );
        }
      );
  }
}