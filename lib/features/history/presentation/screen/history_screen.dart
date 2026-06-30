import 'package:easy_localization/easy_localization.dart';
import 'package:en_touch/core/colors/app_colors.dart';
import 'package:en_touch/core/routes/routes.dart';
import 'package:en_touch/core/services/app_services.dart';
import 'package:en_touch/features/history/presentation/cubit/history_cubit.dart';
import 'package:en_touch/features/inverse%20result/presentation/screen/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});

  final HistoryCubit historyCubit = HistoryCubit();
  final AppServices appServices = AppServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home.history'.tr()),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Image.asset(
              "images/history_icon.png",
              color: Theme.of(context).iconTheme.color,
              width: 29.w,
              height: 27.h,
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.main,arguments: 0);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: BlocBuilder<HistoryCubit, HistoryState>(
        bloc : historyCubit..getHistory(),
        builder: (context, state) {
          if (state is HistoryLoading){
            return const Center(child: CircularProgressIndicator());
          }
          if (state is HistoryError) {
            return Center(child: Text(state.errorMessage));
          }
          return Column(
            children: [
              SizedBox(height: 20.h),
              Expanded(
                child: ListView.builder(
                  itemCount: historyCubit.model.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InverseResultScreen(
                                  videoPath: "https://entouch.runasp.net/videos/${historyCubit.model[index].outputVideoPath}",
                                  resultText: historyCubit.model[index].inputText ?? '',
                                  argument: 1,
                                ),
                              ),
                        
                            );
                          },
                          child: Container(
                            width: 327.w,
                            height: 55.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.textColor,
                                width: 2.w,
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      historyCubit.model[index].inputText ?? 'null',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                  ),
                                  Image.asset(
                                    "images/hand.png",
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ]
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
