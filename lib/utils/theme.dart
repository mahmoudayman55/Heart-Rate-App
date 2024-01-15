import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'custom_colors.dart';

class Themes {
  static  Color darkBlue =const Color.fromARGB(255, 47, 124, 183);
  static  Color softBlue = const Color.fromARGB(255, 194, 227, 251);
  static final TextTheme _phoneTextTheme = TextTheme(
    headlineLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        fontSize: 20.0.sp,
        color: Colors.white),
    headlineMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 18.0.sp,
        color: Colors.white),
    displayLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 16.0.sp,
        color: Colors.white),
    displayMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 12.0.sp,
        color: Colors.white),
    displaySmall: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        fontSize: 10.0.sp,
        color: Colors.white),
    bodyMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.normal,
        fontSize: 10.0.sp,
        color: Colors.white),
    bodySmall: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.normal,
        fontSize: 6.0.sp,
        color: Colors.white),
  );
  static final TextTheme _tabletTextTheme = TextTheme(
    headlineLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 14.0.sp,
        color: Colors.white),
    headlineMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        fontSize: 12.0.sp,
        color: Colors.white),
    displayLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 8.0.sp,
        color: Colors.white),
    displayMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 6.0.sp,
        color: Colors.white),
    displaySmall: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        fontSize: 6.0.sp,
        color: Colors.white),
    bodyMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.normal,
        fontSize: 4.0.sp,
        color: Colors.white),
    bodySmall: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.normal,
        fontSize: 2.0.sp,
        color: Colors.white),
  );

  static final lightTheme = ThemeData.light().copyWith(
    primaryColorLight: CustomColors.primaryColor,
    colorScheme: ThemeData.light().colorScheme.copyWith(primary:  CustomColors.primaryColor,surfaceTint: Colors.transparent),
    scaffoldBackgroundColor: Colors.white,bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Colors.white,),
    dividerColor: Colors.grey.shade300,
    primaryColor: CustomColors.primaryColor,
    primaryColorDark: CustomColors.primaryColor,
    textTheme: SizerUtil.deviceType == DeviceType.mobile
        ? _phoneTextTheme
        : _tabletTextTheme,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: darkBlue,
    ),
  );
}
