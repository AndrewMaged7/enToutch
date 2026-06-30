import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomItems extends StatelessWidget {
  CustomItems({super.key, required this.label, this.label2 = "0", required this.imgPath});

  final String label;
  final String label2;
  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
      child: Container(
        width: 327.w,
        height: 39.h,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).iconTheme.color!, width: 2.w),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: [
              Image.asset(
                imgPath,
                color: Theme.of(context).iconTheme.color,
                height: 20.h,
                width: 22.w,
              ),
              SizedBox(width: 20.w),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Spacer(),
              Text(
                label2 == "0" ? "" : label2,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(width: 10.w),
            ],
          ),
        ),
      ),
    );
  }
}
