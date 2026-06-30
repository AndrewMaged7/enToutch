import 'package:easy_localization/easy_localization.dart';
import 'package:en_touch/core/cache/hive_cach_helper.dart';
import 'package:en_touch/core/colors/app_colors.dart';
import 'package:en_touch/core/routes/routes.dart';
import 'package:en_touch/core/widgets/custom_button.dart';
import 'package:en_touch/features/setting/presentation/cubit/setting_cubit.dart';
import 'package:en_touch/features/setting/presentation/screen/search_friend_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Chats extends StatelessWidget {
  Chats({super.key});

  final SettingCubit settingCubit = SettingCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Chats'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () {
            HiveCacheHelper.saveData("mainTabIndex", 3);
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
      body: BlocBuilder<SettingCubit, SettingState>(
        bloc: settingCubit..getMyChats(),
        builder: (context, state) {
          if (state is GetChatsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GetChatsError) {
            return Center(child: Text(state.errorMessage));
          } else if (state is GetChatsEmpty) {
            return Center(
              child: Text(
                "No chats yet",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              Expanded(
                child: ListView.builder(
                  itemCount: settingCubit.myChats.length,
                  itemBuilder: (context, index) {
                    final messageDate = DateTime.parse(
                      settingCubit.myChats[index].lastMessageAt!,
                    );
                    final now = DateTime.now();
                    final isToday =
                        now.year == messageDate.year &&
                        now.month == messageDate.month &&
                        now.day == messageDate.day;

                    return Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            Navigator.pushNamed(
                              context,
                              Routes.chats,
                              arguments: settingCubit.myChats[index].userId,
                            );
                            await HiveCacheHelper.saveData<String>(
                              'receiverName',
                              settingCubit.myChats[index].fullName!,
                            );
                          },
                          child: Container(
                            width: 317.w,
                            height: 70.h,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 5.w),
                                CircleAvatar(
                                  radius: 25.r,
                                  backgroundImage: AssetImage(
                                    "images/img_profile.png",
                                  ),
                                ),
                                SizedBox(width: 20.w),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        settingCubit.myChats[index].fullName!,
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        settingCubit
                                            .myChats[index]
                                            .lastMessage!,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      isToday
                                          ? DateFormat(
                                              settingCubit
                                                  .myChats[index]
                                                  .lastMessageAt!
                                                  .substring(11, 16),
                                            ).format(
                                              messageDate,
                                            ) //       .substring(0, 10)
                                          : DateFormat(
                                              settingCubit
                                                  .myChats[index]
                                                  .lastMessageAt!
                                                  .substring(0, 10),
                                            ).format(messageDate),
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textColor,
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                    Text(
                                      settingCubit.myChats[index].unreadCount !=
                                              0
                                          ? "${settingCubit.myChats[index].unreadCount}"
                                          : "",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10.w),
                              ],
                            ),
                          ),
                        ),
                        // Spacer(),
                        // CustomButton(label: "New Message", height: 63, width: 224, function: (){print("object");},),
                        SizedBox(height: 10.h),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 60.h),
              CustomButton(
  label: "New Message",
  height: 63.h,
  width: 224.w,
  function: () {
    print("button pressed"); // نشوف لو الـ button شغال
    try {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => SettingCubit(),
            child: SearchFriendScreen(),
          ),
        ),
      );
    } catch (e) {
      print("ERROR: $e"); // نشوف الـ error
    }
  },
),
              SizedBox(height: 80.h),
            ],
          );
        },
      ),
    );
  }
}
