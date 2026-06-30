import 'package:easy_localization/easy_localization.dart';
import 'package:en_touch/core/cache/hive_cach_helper.dart';
import 'package:en_touch/core/routes/routes.dart';
import 'package:en_touch/core/theme/cubit/theme_cubit.dart';
import 'package:en_touch/features/auth/data/models/auth_model.dart';
import 'package:en_touch/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:en_touch/features/setting/presentation/cubit/setting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageAndModeScreen extends StatelessWidget {
  final AuthCubit authCubit = AuthCubit();
  final AuthModel? userModel = HiveCacheHelper.getData<AuthModel>("authData");
  LanguageAndModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: (){
            Navigator.pushNamed(context, Routes.main, arguments: 3);
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('settings.myProfile'.tr(), style: Theme.of(context).textTheme.bodyMedium),
            Text(
              "${userModel?.fullName ?? "User Name"} , ${userModel?.email ?? "user@example.com"}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        toolbarHeight: 50.h,
      ),
      body: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    ExpansionTile(
                      leading: Icon(
                        Icons.language,
                        size: 30.sp,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      title: Text('settings.language'.tr(),style: Theme.of(context).textTheme.bodyMedium),
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 40.w),
                            Container(
                              height: 12.75.h,
                              width: 12.75.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                onTap: () {
                                  context.read<SettingCubit>().changeLanguage(context, 'ar');
                                },
                                title: Text(
                                  "settings.ar".tr(),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 40.w),
                            Container(
                              height: 12.75.h,
                              width: 12.75.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                onTap: () {
                                  context.read<SettingCubit>().changeLanguage(context, 'en');
                                },
                                title: Text(
                                  "settings.en".tr(),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ExpansionTile(
                      leading: Icon(
                        Icons.mode_night,
                        size: 30.sp,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      title: Text('settings.mode'.tr(), style: Theme.of(context).textTheme.bodyMedium),
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 40.w),
                            Container(
                              height: 12.75.h,
                              width: 12.75.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                onTap: () {
                                  themeCubit.changeTheme(true);
                                },
                                title: Text(
                                  "settings.dark".tr(),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 40.w),
                            Container(
                              height: 12.75.h,
                              width: 12.75.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                onTap: () {
                                  themeCubit.changeTheme(false);
                                },
                                title: Text(
                                  "settings.light".tr(),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
    );
  }
}
