import 'package:en_touch/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {

  final String label;
  final num height, width;
  final Color color;
  final bool isPressed;
  final num borderRadius;
  final VoidCallback? function;

  CustomButton({super.key, required this.label, this.function,required this.height, required this.width, this.color = AppColors.buttonColor, this.isPressed = false,this.borderRadius = 6});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height.h,
      minWidth: width.w,
      color: isPressed ? Colors.white : color,
      textColor: isPressed ? Theme.of(context).iconTheme.color : Theme.of(context).iconTheme.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      onPressed: function,
      child: Text(label,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),)
      );
  }
}