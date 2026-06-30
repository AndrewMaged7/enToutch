import 'package:en_touch/features/dictionary/presentation/cubit/dictionary_cubit.dart';
import 'package:en_touch/features/dictionary/presentation/screen/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DictionaryWidget extends StatelessWidget {
  final DictionaryCubit dictionaryCubit;
  final int index;
  DictionaryWidget({
    super.key,
    required this.dictionaryCubit,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VideoPlayerScreen(
              videoId:
                  dictionaryCubit.youtubeVideoModel?[index].videoId ?? 'null',
            ),
          ),
        );
        print(
          "===================================================================",
        );
        print("video id: ${dictionaryCubit.youtubeVideoModel?[index].videoId}");
        print(
          "video title: ${dictionaryCubit.youtubeVideoModel?[index].title}",
        );
        print(
          "video thumbnail: ${dictionaryCubit.youtubeVideoModel?[index].thumbnail}",
        );
        print(
          "===================================================================",
        );
      },
      child: Container(
        height: 50.h,
        width: 327.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            width: 3.sp,
            color: Theme.of(context).iconTheme.color!,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      dictionaryCubit.youtubeVideoModel?[index].title ?? 'null',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: Colors.grey[800]),
                    ),
                  ),
                  // SizedBox(height: 10.h),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Image.network(
              dictionaryCubit.youtubeVideoModel?[index].thumbnail ?? 'null',
              height: 35.h,
              width: 35.w,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    );
  }
}
