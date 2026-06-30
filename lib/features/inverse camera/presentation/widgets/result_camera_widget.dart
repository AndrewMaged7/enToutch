

import 'package:en_touch/core/widgets/video_player_widget.dart';
import 'package:en_touch/core/widgets/welcome_message.dart';
import 'package:en_touch/features/inverse%20camera/presentation/cubit/inverse_camera_cubit.dart';
import 'package:en_touch/features/inverse%20camera/presentation/widgets/choose_trans_or_audio_widget.dart';
import 'package:en_touch/features/inverse%20camera/presentation/widgets/trans_and_audio_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InverseResultWidget extends StatelessWidget {
  const InverseResultWidget({super.key, required this.cameraCubit});
  final InverseCameraCubit cameraCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InverseCameraCubit, InverseCameraState>(
      bloc: cameraCubit,
      builder: (context, state) {
        if (state is InverseTranslationLoading || state is InverseAudioLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is InverseTranslationError ||
            state is InverseAudioError ||
            state is InversePlayVideoError) {
          return Center(child: Text(cameraCubit.error));
        }
        return Column(
          children: [
            WelcomeMessage(),
            SizedBox(height: 30.h),
            Container(
              height: 175.h,
              width: 271.w,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).iconTheme.color!,
                  width: 2.w,
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child:
                  cameraCubit.videoPlayerController != null &&
                      cameraCubit
                          .videoPlayerController!
                          .value
                          .isInitialized
                  ?
                   GestureDetector(
                    onTap: (){
                      cameraCubit.playVideo(cameraCubit.videoFile.videoPath!);
                    },
                     child: VideoPlayerWidget(
                        videoPlayerController:
                            cameraCubit.videoPlayerController,
                      ),
                   )
                  : Center(child: CircularProgressIndicator()),
            ),
            SizedBox(height: 30.h),
            Row(
              children: [
                SizedBox(width: 30.w),
                Expanded(
                  child: Text(
                    cameraCubit.videoFile.prediction!,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: 30.w),
              ],
            ),
            SizedBox(height: 40.h),
            cameraCubit.showTransAndAudio
                ? InverseCameraTransAndAudioWidget(cameraCubit: cameraCubit)
                : InverseCameraChooseTransOrAudioWidget(cameraCubit: cameraCubit),
                
          ],
        );
      },
    );
  }
}
