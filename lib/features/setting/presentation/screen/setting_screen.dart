import 'package:easy_localization/easy_localization.dart';
import 'package:en_touch/core/cache/hive_cach_helper.dart';
import 'package:en_touch/core/routes/routes.dart';
import 'package:en_touch/core/widgets/custom_button.dart';
import 'package:en_touch/features/auth/data/models/auth_model.dart';
import 'package:en_touch/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:en_touch/features/setting/presentation/cubit/setting_cubit.dart';
import 'package:en_touch/features/setting/presentation/widgets/custom_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  final AuthCubit authCubit = AuthCubit();
  final SettingCubit settingCubit = SettingCubit();
  final AuthModel? userModel = HiveCacheHelper.getData<AuthModel>("authData");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home.settings'.tr()),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,color: Theme.of(context).iconTheme.color,),
          onPressed: () => Navigator.pushNamed(context, Routes.main),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Image.asset("images/setting_icon.png",color: Theme.of(context).iconTheme.color,width: 29.w,height: 27.h,),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20.h,),
          InkWell(
            onTap: () => Navigator.pushNamed(context, Routes.languageAndModeScreen),
            child : Container(
              height: 39.h,
              width: 327.w,
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).iconTheme.color!, width: 2.w),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  SizedBox(width: 8.w,),
                  Icon(Icons.language,color: Theme.of(context).iconTheme.color,size: 30.sp,),
                  SizedBox(width: 15.w,),
                  Text('settings.language'.tr(),style: Theme.of(context).textTheme.bodyMedium,),
                  SizedBox(width: 5.w,),
                  Text("and",style: Theme.of(context).textTheme.bodyMedium,),
                  SizedBox(width: 5.w,),
                  Text('settings.mode'.tr(),style: Theme.of(context).textTheme.bodyMedium,),
                ],),
            )
            ),
            SizedBox(height: 8.h,),
          InkWell(
            onTap: () => Navigator.pushNamed(context, Routes.profileScreen),
            child: CustomItems(label: "settings.profile".tr(), imgPath: "images/profile_icon.png")),
          InkWell(
            onTap: () => Navigator.pushNamed(context, Routes.history),
            child: CustomItems(label: "home.history".tr(), imgPath: "images/history_icon.png")),
          InkWell(
            onTap: () => Navigator.pushNamed(context, Routes.suggestions),
            child: CustomItems(label: "settings.suggestions".tr(), imgPath: "images/history_icon.png")),
           InkWell(
            onTap: () => Navigator.pushNamed(context, Routes.requests),
            child: CustomItems(label: "Requests", label2: "${settingCubit.requests.length}", imgPath: "images/history_icon.png")),
          InkWell(
            onTap: () => Navigator.pushNamed(context, Routes.homeChats),
            child: CustomItems(label: "My Chats", imgPath: "images/profile_icon.png")),
            InkWell(
            onTap: () => Navigator.pushNamed(context, Routes.addPost),
            child: CustomItems(label: "Add Post", imgPath: "images/profile_icon.png")),
            Spacer(),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.r),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CustomButton(
                    label: "settings.logout".tr(),
                    height: 63,
                    width: 131,
                    borderRadius: 18,
                    function: () {
                      authCubit.signOut(refreshToken: userModel!.token!);
                      Navigator.pushNamed(context, Routes.signIn);
                    },
                  ),
                ),
              ),
              SizedBox(height: 50.h),
        ],
      )
    );
  }
}