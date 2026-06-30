import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconButton? suffixIcon;
  const CustomTextFormField({super.key, required this.controller, required this.label, this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(  
          controller: controller,
          cursorColor: Theme.of(context).iconTheme.color,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            label: Text(label, style: Theme.of(context).textTheme.bodyMedium),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: BorderSide(
                color: Theme.of(context).iconTheme.color!,
                width: 2.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: BorderSide(
                color: Theme.of(context).iconTheme.color!,
                width: 2.w,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: BorderSide(
                color: Theme.of(context).iconTheme.color!,
                width: 2.w,
              ),
            ),
          ),
        );
  }
}