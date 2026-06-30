import 'package:easy_localization/easy_localization.dart';
import 'package:en_touch/features/learn%20new%20sign/presentation/cubit/learn_new_sign_cubit.dart';
import 'package:en_touch/features/learn%20new%20sign/presentation/screens/sign_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:en_touch/core/routes/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LearnNewSignScreen extends StatelessWidget {
  LearnNewSignScreen({super.key});

  final LearnNewSignCubit learnNewSignCubit = LearnNewSignCubit();

  @override
  Widget build(BuildContext context) {
    learnNewSignCubit.loadSavedItems();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Navigator.pushNamed(context, Routes.main),
        ),
        title: Row(
          children: [Text("home.learnNew".tr()), Text("home.sign".tr())],
        ),
        actions: [
          Image.asset(
            "images/learn.png",
            color: Theme.of(context).iconTheme.color,
            width: 28.w,
            height: 28.h,
          ),
          SizedBox(width: 30.w),
        ],
      ),
      body: BlocBuilder<LearnNewSignCubit, LearnNewSignState>(
        bloc: learnNewSignCubit,
        builder: (context, state) {
          if (state is SaveHistoryLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SaveHistoryError) {
            return Center(child: Text(state.error));
          }
          return ListView.builder(
            itemCount: learnNewSignCubit.texts.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.learnSignResult,
                        arguments: learnNewSignCubit.texts[index],
                      );
                    },
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SignResultScreen(
                              videoId: learnNewSignCubit.videoId[index],
                              text: learnNewSignCubit.texts[index],
                              index: index,
                              learnNewSignCubit: learnNewSignCubit,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 102.h,
                        width: 317.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.r),
                          child: Row(
                            children: [
                              SizedBox(width: 5.w),
                              Image.network(
                                learnNewSignCubit.images[index],
                                height: 103.h,
                                width: 80.w,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  learnNewSignCubit.texts[index],
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              InkWell(
                                onTap: () {
                                  learnNewSignCubit.saveHistory(
                                    learnNewSignCubit.texts[index],
                                    index,
                                  );
                                },
                                child: learnNewSignCubit.savedItems[index]
                                    ? Image.asset(
                                        "images/fill_heart_icon.png",
                                        height: 27.h,
                                        width: 22.w,
                                        fit: BoxFit.contain,
                                      )
                                    : Image.asset(
                                        "images/heart_icon.png",
                                        height: 27.h,
                                        width: 22.w,
                                        fit: BoxFit.contain,
                                      ),
                              ),
                              SizedBox(width: 5.w),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
