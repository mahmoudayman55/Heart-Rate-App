import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:heart_rate/utils/app_assets.dart';
import 'package:heart_rate/utils/app_constants.dart';
import 'package:heart_rate/widgets/faded_widget.dart';

import '../utils/custom_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  void _startDelay() {
    _timer = Timer(const Duration(milliseconds: 2500), () => _goToNextView());
  }

  void _goToNextView() {
 Get.offAllNamed(AppConstants.homeRoute);
 return;

  }

  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  void _setSystemUIOverlayStyle() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    final double bottomPadding = View.of(context).viewPadding.bottom;

    final Color? systemNavigationBarColor =
        bottomPadding > 0 ? null : Colors.transparent;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: systemNavigationBarColor,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    _setSystemUIOverlayStyle();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadedWidget(
      child: Scaffold(
        backgroundColor: CustomColors.primaryColor,
        body: Center(
          child: Image.asset(AppAssets.appIcon),
        ),
      ),
    );
  }
}
