import 'package:easy_localization/easy_localization.dart';
import 'package:en_touch/features/result/presentation/cubit/result_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen({
    super.key,
    this.videoPlayerController,
    required this.videoPath,
    required this.resultText,
  });
  final VideoPlayerController? videoPlayerController;
  final ResultCubit resultCubit = ResultCubit();
  final String videoPath;
  final String resultText;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
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
        title: Text(widget.resultText),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
      body: BlocBuilder<ResultCubit, ResultState>(
        bloc: widget.resultCubit,
        builder: (context, state) {
          if (state is SaveToGalleryError) {
            return Center(child: Text("Error loading result: ${state.error}"));
          } 
          else if (state is SaveToGalleryLoading) {
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
                InkWell(
                  onTap: () {
                    widget.resultCubit.saveToDevice(widget.videoPath);
                  },
                  child: Text("Save To Gallery"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
