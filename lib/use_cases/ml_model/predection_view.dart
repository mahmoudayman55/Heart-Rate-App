import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:heart_rate/use_cases/ml_model/predection_controller.dart';

import 'package:sizer/sizer.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../utils/custom_colors.dart';
import 'bluetooth_controller.dart';

class PredictionView extends StatelessWidget {
  final PredictionController predictionController =
  Get.find<PredictionController>();
  final BleController bleController = Get.find<BleController>();

  PredictionView({super.key});

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

    return Sizer(builder: (context, orientation, deviceType) {
      double width = 100.w;
      double height = 100.h;
      return StreamBuilder<List<int>>(
        stream: bleController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<int> data = snapshot.data!;
            String stringValue = String.fromCharCodes(data);
            int pulseRate = int.parse(stringValue.split(",")[0]);
            int oxygen = int.parse(stringValue.split(",")[1]);
            if (!predictionController.loading.value) {
              predictionController.setUserOxygen(oxygen);
              predictionController.setUserPulseRate(pulseRate);
              predictionController.predict();

            }
            return Center(
              child:
              SizedBox(height: height, width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(flex: 6,
                      child: SleekCircularSlider(
                        appearance: CircularSliderAppearance(
                          customWidths: CustomSliderWidths(
                            trackWidth: 4,
                            progressBarWidth: 20,
                            shadowWidth: 40,
                          ),
                          customColors: CustomSliderColors(
                            trackColor: Colors.deepOrange,
                            progressBarColor: CustomColors.primaryColor,
                            shadowColor: Colors.red.shade800,
                            shadowMaxOpacity: 0.5,
                            //);
                            shadowStep: 20,
                          ),
                          infoProperties: InfoProperties(
                            bottomLabelStyle: const TextStyle(
                              color: CustomColors.primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            bottomLabelText: pulseRate.toString(),
                            mainLabelStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 25.0,
                              fontWeight: FontWeight.w600,
                            ),
                            modifier: (double value) {
                              return 'Heart Rate';
                            },
                          ),
                          startAngle: 10,
                          angleRange: 360,
                          size: 250.0,
                          animationEnabled: true,
                        ),
                        min: 0,
                        max: 300,
                        initialValue: 5.toDouble(),
                      ),
                    ),

                    Expanded(flex: 6,
                      child: SleekCircularSlider(
                        appearance: CircularSliderAppearance(
                          customWidths: CustomSliderWidths(
                            trackWidth: 4,
                            progressBarWidth: 20,
                            shadowWidth: 40,
                          ),
                          customColors: CustomSliderColors(
                            trackColor: Colors.blue.shade200,
                            progressBarColor: Colors.blue,
                            shadowColor: Colors.blue.shade800,
                            shadowMaxOpacity: 0.5,
                            //);
                            shadowStep: 20,
                          ),
                          infoProperties: InfoProperties(
                            bottomLabelStyle: const TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            bottomLabelText: "$oxygen %",
                            mainLabelStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 25.0,
                              fontWeight: FontWeight.w600,
                            ),
                            modifier: (double value) {
                              return 'SPO2';
                            },
                          ),
                          startAngle: 10,
                          angleRange: 360,
                          size: 250.0,
                          animationEnabled: true,
                        ),
                        min: 0,
                        max: 100,
                        initialValue: 6.toDouble(),
                      ),
                    ),


                    Expanded(flex: 1,
                      child: Container(alignment: Alignment.center,
                        width: width,
                        child: Obx(
                              () =>
                          predictionController.loading.value
                              ? Text(
                            predictionController.predictionResult.value,
                            style: Theme
                                .of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(color: CustomColors.primaryColor),
                          ) : AnimatedTextKit(
                            isRepeatingAnimation: false,
                            animatedTexts: [
                              TyperAnimatedText(
                                "Loading...",
                                textAlign: TextAlign.center,
                                speed: const Duration(milliseconds: 100),
                                textStyle: const TextStyle(
                                  color: CustomColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
                                ),
                              ),
                            ],
                          ),
                        )
                        ,),
                    ),

                  ],
                ),
              ),

            );
          } else {
            predictionController.setUserPulseRate(90);
            predictionController.setUserOxygen(60);
            return

              Obx(
                    () =>
                    Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('No data',
                            style: Theme
                                .of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(color: Colors.black)),
                        Text(
                          "try with data: Pulse rate:90 ||| oxygen: 60%",
                          style: Theme
                              .of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: Colors.black),
                        ),

                        const SizedBox(height: 15),
                        predictionController.loading.value
                            ? AnimatedTextKit(
                          isRepeatingAnimation: false,
                          animatedTexts: [
                            TyperAnimatedText(
                              "Loading...",
                              textAlign: TextAlign.center,
                              speed: const Duration(milliseconds: 100),
                              textStyle: const TextStyle(
                                color: CustomColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                              ),
                            ),
                          ],
                        )
                            : Text(
                          predictionController.predictionResult.value,
                          style: Theme
                              .of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: CustomColors.primaryColor),
                        ),
                        ElevatedButton(
                            onPressed: () => predictionController.predict(),
                            child: Text("Try",style:Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black)))

                        ,

                      ],
                    ),
              );
          }
        },
      );
    });
  }
}

