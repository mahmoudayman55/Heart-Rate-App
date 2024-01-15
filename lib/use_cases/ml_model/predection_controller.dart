import 'dart:developer';
import 'package:get/get.dart';
import 'package:dio/dio.dart';


import 'package:flutter/material.dart';

import '../pill_reminder/custom_snack_bar.dart';

class PredictionController extends GetxController {
  RxBool loading = RxBool(false);
  RxInt userOxygen = 0.obs;
  RxInt userPulseRate = 0.obs;
  RxString predictionResult = ''.obs;
  final formKey = GlobalKey<FormState>();
  TextEditingController baseUrlController = TextEditingController();

  void setUserOxygen(int value) => userOxygen.value = value;

  void setUserPulseRate(int value) => userPulseRate.value = value;
  final Dio _dio = Dio();


  String? baseUrl;

  Future<void> predict() async {

    String apiUrl = '${baseUrl!}/predict';

    try {
      loading.value = true;
      final response = await _dio.post(
        apiUrl,
        data: {
          'oxygen': userOxygen.value,
          'pulse_rate': userPulseRate.value,
        },
      );

      if (response.statusCode == 200) {
        log(response.data.toString());
        predictionResult.value = response.data['prediction'][0];
        await Future.delayed(const Duration(seconds: 5));
        loading.value = false;
      } else {
        await Future.delayed(const Duration(seconds: 5));

        loading.value = false;
      }
    } on DioException catch (error) {
      customSnackBar(
          title: "Error",
          message: 'Error: ${error.message} $error',
          successful: false);
      await Future.delayed(const Duration(seconds: 5));

      loading.value = false;
    }
  }
}
