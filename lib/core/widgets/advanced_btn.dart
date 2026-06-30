import 'package:en_touch/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdvancedBtn extends StatelessWidget {
  final String img;
  final String? label_1;
  final String? label_2;
  final num height;
  final num width;
  final num imgWidth;
  final num imgHeight;
  AdvancedBtn({
    super.key,
    required this.img,
    this.height = 147,
    this.width = 147,
    this.imgWidth = 50,
    this.imgHeight = 50,
    this.label_1,
    this.label_2,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.buttonColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10.h),
            Expanded(
              child: Image.asset(
                img,
                color: Colors.white,
                width: imgWidth.w,
                height: imgHeight.h,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 5.h),
            Expanded(
              child: Column(
                children: [
                  Text(
                    label_1 ?? "",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white70),
                  ),
                  label_2 != null && label_2 != ""
                      ? Text(
                          label_2!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white70)
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
