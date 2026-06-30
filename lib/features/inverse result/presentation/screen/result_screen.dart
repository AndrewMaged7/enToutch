import 'package:easy_localization/easy_localization.dart';
import 'package:en_touch/core/widgets/custom_button.dart';
import 'package:en_touch/features/inverse%20camera/presentation/screens/camera_screen.dart';
import 'package:en_touch/features/inverse%20result/presentation/cubit/result_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class InverseResultScreen extends StatefulWidget {
  InverseResultScreen({
    super.key,
    this.videoPlayerController,
    required this.videoPath,
    required this.resultText,
    this.argument = 0,
  });
  final VideoPlayerController? videoPlayerController;
  final InverseResultCubit resultCubit = InverseResultCubit();
  final String videoPath;
  final String resultText;
  final int argument;


  @override
  State<InverseResultScreen> createState() => _InverseResultScreenState();
}

class _InverseResultScreenState extends State<InverseResultScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.videoPath.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.resultCubit.playVideo(widget.videoPath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<InverseResultCubit, InverseResultState>(
        
        bloc: widget.resultCubit,
        builder: (context, state) {
          if (state is InverseResultSaveToGalleryError) {
            return Center(child: Text("Error loading result: ${state.error}"));
          } else if (state is InverseResultSaveToGalleryLoading || state is InverseResultLoading) {
            return Center(child: CircularProgressIndicator());
          } 
          return Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                Text(
                  "camera.result".tr(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: 30.h),
                Container(
                  height: 186.h,
                  width: 324.w,
                  child:
                      widget.resultCubit.videoPlayerController != null &&
                          widget
                              .resultCubit
                              .videoPlayerController!
                              .value
                              .isInitialized
                      ? GestureDetector(
                          onTap: () {
                            widget.resultCubit.playVideo(widget.videoPath);
                          },
                          child: AspectRatio(
                            aspectRatio: widget
                                .resultCubit
                                .videoPlayerController!
                                .value
                                .aspectRatio,
                            child: VideoPlayer(
                              widget.resultCubit.videoPlayerController!,
                            ),
                          ),
                        )
                      : Center(child: CircularProgressIndicator()),
                ),
                SizedBox(height: 30.h),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.resultText,
                    // style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
                  ),
                ),
                SizedBox(height: 30.h),
                InkWell(
                  onTap: () {
                    widget.resultCubit.saveToDevice(widget.videoPath);
                  },
                  child: Text("Save To Gallery"),
                ),
                SizedBox(height: 30.h),
                widget.argument == 0 ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  label: "camera.answer".tr(),
                  height: 49,
                  width: 124,
                  borderRadius: 8,
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InverseCameraScreen(
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(width: 30.w),
              ],
            ) : SizedBox.shrink(),
              ],
            ),
          );
        },
      ),
    );
  }
}
