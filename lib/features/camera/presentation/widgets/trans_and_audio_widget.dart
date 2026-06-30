import 'package:easy_localization/easy_localization.dart';
import 'package:en_touch/core/routes/routes.dart';
import 'package:en_touch/core/widgets/custom_button.dart';
import 'package:en_touch/features/camera/presentation/cubit/camera_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransAndAudioWidget extends StatelessWidget {
  final CameraCubit cameraCubit;
  const TransAndAudioWidget({super.key, required this.cameraCubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraCubit, CameraState>(
      bloc: cameraCubit,
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                SizedBox(width: 30.w),
                Expanded(
                  child: Text(
                    cameraCubit.translationText,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.end,
                  ),
                ),
                SizedBox(width: 15.w),
                CustomButton(
                  label: "camera.translate".tr(),
                  height: 49,
                  width: 124,
                  borderRadius: 8,
                  function: () {
                    cameraCubit.translation(
                      cameraCubit.videoFile.prediction!,
                    );
                  },
                ),
                SizedBox(width: 30.w),
              ],
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                cameraCubit.isPlaying
                    ? Padding(
                        padding: EdgeInsets.only(left: 100.w),
                        child: Image.asset(
                          "images/audio_play.png",
                          width: 35.w,
                          height: 35.h,
                          color: Theme.of(context).iconTheme.color,
                          fit: BoxFit.fill,
                        ),
                      )
                    : Container(),
                SizedBox(width: 70.w),
                CustomButton(
                  label: "camera.audio".tr(),
                  height: 49,
                  width: 124,
                  borderRadius: 8,
                  function: () {
                    cameraCubit.audio(
                      cameraCubit.videoFile.prediction!,
                    );
                  },
                ),
                SizedBox(width: 30.w),
              ],
            ),
            SizedBox(height: 30.h),
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
          ],
        );
      },
    );
  }
}
