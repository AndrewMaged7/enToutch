import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';

class CommunicationTypes extends StatelessWidget {
  final String label;
  final String img;
  final int fontSize;
  final int iconWidth;
  final int iconHeight;
  CommunicationTypes({super.key, required this.label, required this.img,this.fontSize = 16,this.iconWidth = 25,this.iconHeight = 25});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62.h,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).iconTheme.color!, width: 2.w),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 15.w,),
          Image.asset(img,color: Theme.of(context).iconTheme.color!,height: iconHeight.h,width: iconWidth.w,fit: BoxFit.cover,),
          SizedBox(width: 8.w,),
          Expanded(child: Text(label, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: fontSize.sp),))
        ],
      ),
    );
  }
}