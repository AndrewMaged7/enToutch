import 'package:easy_localization/easy_localization.dart';
import 'package:en_touch/core/routes/routes.dart';
import 'package:en_touch/core/widgets/custom_button.dart';
import 'package:en_touch/features/camera/presentation/cubit/camera_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseTransOrAudioWidget extends StatelessWidget {
  final CameraCubit cameraCubit;
  const ChooseTransOrAudioWidget({super.key, required this.cameraCubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  label: "camera.answer".tr(),
                  height: 49,
                  width: 124,
                  borderRadius: 8,
                  function: () {
                    Navigator.pushNamed(context, Routes.answerScreen);
                  },
                ),
                SizedBox(width: 30.w),
              ],
            ),
        SizedBox(height: 40.h),
        Row(
          children: [
            SizedBox(width: 56.w),
            Container(height: 2.h, width: 124.w, color: Theme.of(context).iconTheme.color),
            SizedBox(width: 5.w),
            Text(
              "camera.or".tr(),
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(width: 5.w),
            Container(height: 2.h, width: 124.w, color: Theme.of(context).iconTheme.color),
          ],
        ),
        SizedBox(height: 60.h),
        Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 10.w),
                CustomButton(
                  label: "camera.translate".tr(),
                  height: 49,
                  width: 124,
                  borderRadius: 8,
                  function: () {cameraCubit.showTransAndAudioWidget();},
                ),
                CustomButton(
                  label: "camera.audio".tr(),
                  height: 49,
                  width: 124,
                  borderRadius: 8,
                  function: () {cameraCubit.showTransAndAudioWidget();},
                ),
                SizedBox(width: 10.w),
              ],
            ),
      ],
    );
  }
}
