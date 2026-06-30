import 'package:en_touch/core/colors/app_colors.dart';
import 'package:en_touch/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpWidget extends StatelessWidget {
  OtpWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.index,
    required this.authCubit,
  });
  final TextEditingController controller;
  final FocusNode focusNode;
  final int index;
  final AuthCubit authCubit;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50.r,
      child: SizedBox(
        width: 50.w,
        height: 50.h,
        child: Focus(
          onKeyEvent: (node, event) {
            if (event is KeyDownEvent &&
                event.logicalKey == LogicalKeyboardKey.backspace &&
                controller.text.isEmpty &&
                index > 0) {
              authCubit.otpFocusNodes[index - 1].requestFocus();
              return KeyEventResult.handled;
            }
            return KeyEventResult.ignored;
          },
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            focusNode: focusNode,
            textAlign: TextAlign.center,
            maxLength: 1,

            decoration: InputDecoration(
              counterText: "",
              filled: true,
              fillColor: AppColors.otpBackground,

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(60.r),
                borderSide: BorderSide(
                  color: AppColors.otpBackground,
                  width: 2,
                ),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(60.r),
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
            ),

            onChanged: (value) {
              if (value.isNotEmpty && index < 5) {
                authCubit.otpFocusNodes[index + 1].requestFocus();
              }
            },
          ),
        ),
      ),
    );
  }
}




















// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class OtpWidget extends StatelessWidget {
//   const OtpWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 56.w,
//       height: 56.h,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey, width: 2),
//         color: Colors.grey[400],
//         borderRadius: BorderRadius.circular(60.r),
//       ),
//     );
//   }
// }