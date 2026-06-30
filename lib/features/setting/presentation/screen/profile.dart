import 'package:easy_localization/easy_localization.dart';
import 'package:en_touch/core/cache/hive_cach_helper.dart';
import 'package:en_touch/core/routes/routes.dart';
import 'package:en_touch/features/auth/data/models/auth_model.dart';
import 'package:en_touch/features/setting/presentation/cubit/setting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends StatelessWidget {
  final AuthModel? userModel = HiveCacheHelper.getData<AuthModel>("authData");
  Profile({super.key});
  final SettingCubit settingCubit = SettingCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings.myProfile'.tr()),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () {
            Navigator.pushNamed(context, Routes.main, arguments: 3);
          },
        ),
        actions: [
          Image.asset(
            "images/profile_icon.png",
            color: Theme.of(context).iconTheme.color,
          ),
          SizedBox(width: 20.w),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10.h),
                  CircleAvatar(
                    radius: 70.r,
                    backgroundImage: AssetImage("images/img_profile.png"),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    userModel?.fullName ?? "User Name",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    userModel?.isDeaf == true && userModel?.isMute == true
                        ? "Deaf And Mute"
                        : "Normal",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),
          SizedBox(height: 20.h),
          Row(
            children: [
              SizedBox(width: 20.w),
              Text("settings.friends".tr(), style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: BlocBuilder<SettingCubit, SettingState>(
              bloc: settingCubit..getFriends(),
              builder: (context, state) {
                if (state is GetFriendsLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is GetFriendsError) {
                  return Center(child: Text(state.errorMessage));
                }
                if(settingCubit.friends.isEmpty){
                  return Center(child: Text("No Friends Yet"));
                }
                return ListView.builder(
                  itemCount: settingCubit.friends.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Delete Friend",style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black)),
                                  content: Text("Are you sure you want to delete this friend?",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black)),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        settingCubit.deleteFriend(settingCubit.friends[index].id!);
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                         SnackBar(content: Text("Friend deleted from ${settingCubit.friends[index].fullName}"))
                                       );
                                      },
                                      child: Text("Delete"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Container(
                              width: 343.w,
                              height: 64.h,
                              child: Row(
                                children: [
                                  SizedBox(width: 10.w),
                                  Image.asset(
                                    "images/img_profile.png",
                                    width: 57.w,
                                    height: 57.h,
                                  ),
                                  SizedBox(width: 10.w),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        settingCubit.friends[index].fullName ?? "User Name",
                                        style: Theme.of(context).textTheme.bodyMedium!,
                                      ),
                                      Text(
                                        settingCubit.friends[index].isDeaf == true && settingCubit.friends[index].isMute == true ? "Deaf and Mute" : "Normal",
                                        style: Theme.of(context).textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Spacer(),
                            InkWell(
                              onTap: () async {
                                Navigator.pushNamed(context, Routes.chats,arguments: settingCubit.friends[index].id!);
                                await HiveCacheHelper.saveData<String>('receiverName', settingCubit.friends[index].fullName!);
                              },
                              child: Text(
                                "Message",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                        SizedBox(width: 20.w),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
