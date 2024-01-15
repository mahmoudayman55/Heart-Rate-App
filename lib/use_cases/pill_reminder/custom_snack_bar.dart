import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/theme.dart';

SnackbarController customSnackBar({

  required String title,
  required String message,
  required bool successful,
}) {
  return Get.snackbar(
    title,
    message,
    titleText: Text(
      title,
      style: Themes.lightTheme.textTheme.bodyMedium!.copyWith(color: Colors.white),
    ),
    messageText: Text(
      message,
      style:Themes.lightTheme.textTheme.bodyMedium!.copyWith(color: Colors.white),
    ),
    backgroundColor: successful ? Colors.lightGreen : Colors.red,
    icon: Icon(
      successful ? Icons.check : Icons.error,
      color: Colors.white,
    ),
    duration: const Duration(seconds: 3),
  );
}
