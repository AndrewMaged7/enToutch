import 'package:en_touch/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  scaffoldBackgroundColor: Colors.white,

  iconTheme: IconThemeData(color: AppColors.textColor),


  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.appBarTextColor,
    ),
    iconTheme: IconThemeData(color: AppColors.textColor),
    actionsIconTheme: IconThemeData(color: AppColors.textColor),
  ),


  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
      color: Colors.black87,
    ),
    bodyMedium: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: Colors.black87,
    ),
    bodySmall: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: Colors.black87,
    ),
  ),



  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.textColor,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.r),
      borderSide: BorderSide(color: Colors.black, width: 2.w),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.r),
      borderSide: BorderSide(color: AppColors.appBarTextColor, width: 2.w),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.r),
      borderSide: BorderSide(color: AppColors.appBarTextColor, width: 2.w),
    ),
  ),



  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.buttonColor,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
),
);
