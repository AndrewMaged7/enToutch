import 'package:en_touch/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialIconWidget extends StatelessWidget {
  final String imgUrl;
  const SocialIconWidget({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 71.53.h,
      width: 71.53.w,
      child: CircleAvatar(
        backgroundColor: AppColors.buttonColor,
        radius: 71.53.r,
        child: Image.asset(imgUrl),
      ),
    );
  }
}