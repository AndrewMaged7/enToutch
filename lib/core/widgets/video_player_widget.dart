import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController? videoPlayerController;

  const VideoPlayerWidget({super.key, this.videoPlayerController});

  @override
  Widget build(BuildContext context) {
    if (videoPlayerController == null ||
        !videoPlayerController!.value.isInitialized) {
      return Container(
        width: 200.w,
        height: 150.h,
        color: Colors.black,
        child: const Center(
          child: Icon(Icons.play_circle_outline, color: Colors.white, size: 48),
        ),
      );
    }

    return SizedBox(
      width: 200.w,
      height: 150.h,
      child: AspectRatio(
        aspectRatio: videoPlayerController!.value.aspectRatio,
        child: VideoPlayer(videoPlayerController!),
      ),
    );
  }
}















// import 'package:en_touch/core/colors/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:video_player/video_player.dart';

// class VideoPlayerWidget extends StatelessWidget {
//   final VideoPlayerController? videoPlayerController;
//   final bool isLoading;

//   const VideoPlayerWidget({
//     super.key,
//     required this.videoPlayerController,
//     this.isLoading = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 186.h,
//       width: 324.w,
//       decoration: BoxDecoration(
//         border: Border.all(color: AppColors.buttonColor, width: 2.w),
//         borderRadius: BorderRadius.circular(8.r),
//       ),
//       child: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : videoPlayerController != null &&
//                   videoPlayerController!.value.isInitialized
//               ? Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     AspectRatio(
//                       aspectRatio: videoPlayerController!.value.aspectRatio,
//                       child: VideoPlayer(videoPlayerController!),
//                     ),
//                     // Tap to pause/resume icon
//                     Icon(
//                       videoPlayerController!.value.isPlaying
//                           ? Icons.pause_circle
//                           : Icons.play_circle,
//                       color: Colors.white70,
//                       size: 48,
//                     ),
//                   ],
//                 )
//               // Not yet loaded — show thumbnail/play button
//               : Center(
//                   child: Image.asset(
//                     "images/play_video.png",
//                     width: 51.63.w,
//                     height: 51.63.h,
//                   ),
//                 ),
//     );
//   }
// }























// import 'package:en_touch/core/colors/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:video_player/video_player.dart';

// class VideoPlayerWidget extends StatelessWidget {
//   final VideoPlayerController? videoPlayerController;
//   final bool isLoading;

//   const VideoPlayerWidget({super.key, required this.videoPlayerController, bool isLoading = false}) : isLoading = isLoading;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//               height: 186.h,
//               width: 324.w,
//               decoration: BoxDecoration(
//                 border: Border.all(color: AppColors.buttonColor, width: 2.w),
//                 borderRadius: BorderRadius.circular(8.r),
//               ),
//               child:
//                   videoPlayerController != null &&
//                       videoPlayerController!.value.isInitialized
//                   ? AspectRatio(
//                       aspectRatio:
//                           videoPlayerController!.value.aspectRatio,
//                       child: VideoPlayer(videoPlayerController!),
//                     )
//                   : Center(child: Image.asset("images/play_video.png",width: 51.63.w,height: 51.63.h,)),
//             );
//   }
// }