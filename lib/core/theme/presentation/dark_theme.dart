// import 'package:en_touch/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  scaffoldBackgroundColor: Colors.grey[900],
  iconTheme: IconThemeData(color: Colors.white),


  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[800],
    titleTextStyle: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    iconTheme: IconThemeData(color: Colors.white),
    actionsIconTheme: IconThemeData(color: Colors.white),
  ),


  textTheme: TextTheme(
    bodyLarge: GoogleFonts.inter(
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    
    bodyMedium: GoogleFonts.inter(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: Colors.white70,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: Colors.white70,
    ),
  ),



  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.r),
      borderSide: BorderSide(color: Colors.white, width: 2.w),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.r),
      borderSide: BorderSide(color: Colors.white, width: 2.w),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.r),
      borderSide: BorderSide(color: Colors.white, width: 2.w),
    ),
  ),
  

  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Colors.grey[800],
  ),


  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.grey[800],
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.white70,
      selectedLabelStyle: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: Colors.white70,
      ),
),
);
