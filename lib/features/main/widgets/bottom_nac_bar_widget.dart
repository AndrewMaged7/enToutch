import 'package:easy_localization/easy_localization.dart';
import 'package:en_touch/features/main/cubit/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key, required this.mainCubit});

  final MainCubit mainCubit;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: mainCubit.currentIndex,
      onTap: mainCubit.changeTab,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Image.asset('images/home_icon.png',color: Colors.white,height: 42.h,width: 43.w),
          activeIcon: Image.asset('images/home_icon.png',color: Colors.black,height: 42.h,width: 43.w),
          label: 'home.home'.tr(),
          
        ),
        BottomNavigationBarItem(
          icon: Image.asset('images/history_icon.png',color: Colors.white,height: 42.h,width: 43.w),
          activeIcon: Image.asset('images/history_icon.png',color: Colors.black,height: 42.h,width: 43.w),
          label: 'home.history'.tr(),
        ),
        BottomNavigationBarItem(
          icon: Image.asset('images/dic_icon.png',color: Colors.white,height: 42.h,width: 43.w),
          activeIcon: Image.asset('images/dic_icon.png',color: Colors.black,height: 42.h,width: 43.w),
          label: 'home.dictionary'.tr(),
        ),
        BottomNavigationBarItem(
          icon: Image.asset('images/setting_icon.png',color: Colors.white,height: 42.h,width: 43.w),
          activeIcon: Image.asset('images/setting_icon.png',color: Colors.black,height: 42.h,width: 43.w),
          label: 'home.settings'.tr(),
        ),
      ],
    );
  }
}