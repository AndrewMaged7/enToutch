

import 'package:easy_localization/easy_localization.dart';
import 'package:en_touch/core/widgets/custom_button.dart';
import 'package:en_touch/features/inverse%20camera/presentation/cubit/inverse_camera_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InverseCameraChooseTransOrAudioWidget extends StatelessWidget {
  final InverseCameraCubit cameraCubit;
  const InverseCameraChooseTransOrAudioWidget({super.key, required this.cameraCubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
