import 'package:en_touch/core/cache/hive_cach_helper.dart';
import 'package:en_touch/core/routes/routes.dart';
import 'package:en_touch/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoarding extends StatelessWidget {
  OnBoarding({Key? key}) : super(key: key);

  

  

  @override
  Widget build(BuildContext context) {

   final pages = [
    PageModel.withChild(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 88.h),
          Image.asset('images/boarding_1.png',height: 273.h,width: 273.w, fit: BoxFit.contain),
          SizedBox(height: 81.h),
          Text("Translate sign",style: GoogleFonts.inter(fontSize: 20.sp,fontWeight: FontWeight.w600,fontStyle: FontStyle.italic),),
          Text("instantly",style: GoogleFonts.inter(fontSize: 20.sp,fontWeight: FontWeight.w600,fontStyle: FontStyle.italic),),
          SizedBox(height: 40.h),
          Text("Convert Sign Language To",style: GoogleFonts.inter(fontSize: 20.sp,fontWeight: FontWeight.w600,fontStyle: FontStyle.italic),),
          Text("Text And Audio Easily",style: GoogleFonts.inter(fontSize: 20.sp,fontWeight: FontWeight.w600,fontStyle: FontStyle.italic),),
          SizedBox(height: 60.h),
          CustomButton(label: "Start", height: 44, width: 203,borderRadius: 16, function: () {
            Navigator.pushReplacementNamed(context, Routes.signIn);
          HiveCacheHelper.saveData<bool>("isFirstTime",false);
          },)
        ],
      )
    ),
    PageModel.withChild(
      color: Colors.transparent,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('images/onboarding 5.png', fit: BoxFit.cover),
          Positioned(
            top: 580.h,
            left: 42.w,
            child: Column(
              children: [
                Text("Translate signs instantly",style: GoogleFonts.inter(fontSize: 24.sp,fontWeight: FontWeight.w500,fontStyle: FontStyle.italic,color: Colors.white),),
                Text("with your camera",style: GoogleFonts.inter(fontSize: 24.sp,fontWeight: FontWeight.w500,fontStyle: FontStyle.italic,color: Colors.white),),
              ],
            ),),
        ],
      ),
    ),
    PageModel.withChild(
      color: Colors.transparent,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('images/onboarding 4.png', fit: BoxFit.cover),
        ],
      ),
    ),
  ];





    return Scaffold(
      body: OverBoard(
        pages: pages,
        showBullets: true,
        inactiveBulletColor: Colors.grey,
        activeBulletColor: Colors.blue,
        skipCallback: () {
          Navigator.pushReplacementNamed(
            context,
            Routes.signIn);
          HiveCacheHelper.saveData<bool>("isFirstTime",false);
        },
        finishCallback: () {
          Navigator.pushReplacementNamed(
            context,
            Routes.signIn);
          HiveCacheHelper.saveData<bool>("isFirstTime",false);
        },
      ),
    );
  }
}


