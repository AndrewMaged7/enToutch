// import 'package:en_touch/core/cache/hive_cach_helper.dart';
import 'package:en_touch/core/routes/routes.dart';
import 'package:en_touch/features/setting/presentation/cubit/setting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Requests extends StatelessWidget {
  Requests({super.key});
  final SettingCubit settingCubit = SettingCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Requests'),
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
        bloc: settingCubit..getPending(),
        builder: (context, state) {
          if (state is PendingLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PendingError) {
            return Center(child: Text(state.errorMessage,style: Theme.of(context).textTheme.bodyLarge));
          }
          else if(state is PendingEmpty){
            return Center(child: Text("No requests",style: Theme.of(context).textTheme.bodyLarge));
          }
          return Column(
            children: [
              SizedBox(height: 20.h),
              Expanded(
                child: ListView.builder(
                  itemCount: settingCubit.requests.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          width: 322.w,
                          height: 83.h,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 20.w),
                              CircleAvatar(
                                radius: 30.r,
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
                                    SizedBox(height: 20.h),
                                    Text(
                                      settingCubit.requests[index].fullName??"Unknown User",
                                      style: Theme.of(context).textTheme.bodyMedium
                                    ),
                                    SizedBox(height: 20.h),
                                  ],
                                ),
                              ),
                              SizedBox(width: 5.w),
                              IconButton(
                               onPressed: () {
                                 settingCubit.acceptRequest(settingCubit.requests[index].id!);
                                 ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(content: Text("Friend request from ${settingCubit.requests[index].fullName} accepted"))
                                 );
                               },
                               icon: Icon(Icons.check)),
                              IconButton(
                               onPressed: () {
                                 settingCubit.rejectRequest(settingCubit.requests[index].id!);
                                 ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(content: Text("Friend request from ${settingCubit.requests[index].fullName} rejected"))
                                 );
                               },
                               icon: Icon(Icons.close)),
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
