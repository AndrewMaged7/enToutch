import 'package:easy_localization/easy_localization.dart';
import 'package:en_touch/features/text%20to%20sign/presentation/cubit/text_to_sign_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:en_touch/core/routes/routes.dart';

class TextToSignScreen extends StatefulWidget {
  final TextToSignCubit textToSignCubit;
  const TextToSignScreen({super.key, required this.textToSignCubit});

  @override
  State<TextToSignScreen> createState() => _TextToSignScreenState();
}
class _TextToSignScreenState extends State<TextToSignScreen> {
  @override
  void initState() {
    super.initState();
    widget.textToSignCubit.processVideoToSign();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,
              color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.pushNamed(context, Routes.main),
        ),
        title: Row(
          children: [
            Text("home.textTo".tr()),
            SizedBox(width: 3.w),
            Text("home.sign".tr()),
          ],
        ),
      ),
      body: BlocBuilder<TextToSignCubit, TextToSignState>(
        bloc: widget.textToSignCubit,
        builder: (context, state) {
          if (state is VideoToSignLoading || state is TextToSignLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is VideoToSignError) {
            return Center(child: Text(state.error));
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),
                Container(
                  height: 186.h,
                  width: 324.w,
                  child: widget.textToSignCubit.videoPlayerController != null &&
                      widget.textToSignCubit.videoPlayerController!.value.isInitialized
                      ? GestureDetector(
                    onTap: () {
                      widget.textToSignCubit.playVideo(
                        widget.textToSignCubit.videoUrl ?? '',
                      );
                    },
                    child: AspectRatio(
                      aspectRatio: widget.textToSignCubit
                          .videoPlayerController!.value.aspectRatio,
                      child: VideoPlayer(
                        widget.textToSignCubit.videoPlayerController!,
                      ),
                    ),
                  )
                      : Container(),
                ),
                SizedBox(height: 20.h),
                Text(widget.textToSignCubit.extractAudioModel?.transcribedText ?? ''),
                SizedBox(height: 50.h),
                InkWell(
                  onTap: () {
                    if (widget.textToSignCubit.videoUrl != null) {
                      widget.textToSignCubit.saveToDevice(
                          widget.textToSignCubit.videoUrl!);
                    }
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