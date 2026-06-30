import 'package:easy_localization/easy_localization.dart';
// import 'package:en_touch/core/cache/hive_cach_helper.dart';
import 'package:en_touch/core/routes/routes.dart';
import 'package:en_touch/features/setting/presentation/cubit/setting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Suggestions extends StatelessWidget {
  Suggestions({super.key});
  final SettingCubit settingCubit = SettingCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings.suggestions'.tr()),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () {
            Navigator.pushNamed(context, Routes.main, arguments: 3);
          },
        ),
      ),
      body: BlocBuilder<SettingCubit, SettingState>(
        bloc: settingCubit..getFriendSuggestions(),
        builder: (context, state) {
          if (state is FriendSuggestionsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FriendSuggestionsError) {
            return Center(child: Text(state.errorMessage));
          }
          return Column(
            children: [
              SizedBox(height: 20.h),
              Expanded(
                child: ListView.builder(
                  itemCount: settingCubit.friendSuggestions.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          width: 322.w,
                          height: 83.h,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 30.r,
                                backgroundImage: AssetImage(
                                  "images/img_profile.png",
                                ),
                              ),
                              SizedBox(width: 20.w),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 7.h),
                                    Text(
                                      settingCubit
                                              .friendSuggestions[index]
                                              .fullName ??
                                          "Unknown User",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                    ),
                                    SizedBox(height: 5.h),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            settingCubit
                                                        .friendSuggestions[index]
                                                        .isDeaf! &&
                                                    settingCubit
                                                            .friendSuggestions[index]
                                                            .isMute ==
                                                        true
                                                ? "Deaf And Mute"
                                                : "Normal",
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodySmall,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            settingCubit.sendRequest(
                                              settingCubit
                                                  .friendSuggestions[index]
                                                  .id!,
                                            );
                                            settingCubit.getFriendSuggestions();
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "Friend request sent to ${settingCubit.friendSuggestions[index].fullName}",
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            "Add Friend",
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodySmall,
                                          ),
                                        ),
                                        SizedBox(width: 5.w),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
