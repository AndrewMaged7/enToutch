import 'package:en_touch/core/routes/routes.dart';
import 'package:en_touch/core/widgets/custom_button.dart';
import 'package:en_touch/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:en_touch/features/auth/presentation/widgets/otp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendOtpScreen extends StatelessWidget {
  SendOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = ModalRoute.of(context)?.settings.arguments as AuthCubit;
    return BlocConsumer<AuthCubit, AuthState>(
      bloc: authCubit,
      listener: (context, state) {
        if(state is SendOtpSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("OTP sent successfully! Please check your inbox."))
          );
          Navigator.pushNamed(context, Routes.sendNewPass,arguments: authCubit);
        }
      },
        builder: (context, state) {
          if(state is SendOtpLoading) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (state is SendOtpError) {
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(state.message),
                  SizedBox(height: 20.h),
                  CustomButton(
                    label: "Retry",
                    height: 52,
                    width: 327,
                    function: () {
                      Navigator.pushNamed(context, Routes.sendOtp);
                    },
                  ),
                ],
              ),
            );
          }
          return Scaffold(
            body: Column(
              children: [
                SizedBox(height: 114.h),
                Align(
                  alignment: AlignmentGeometry.center,
                  child: Text(
                    "Verification",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                SizedBox(height: 50.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.r),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: OtpWidget(
                          controller: authCubit.optNum1,
                          focusNode: authCubit.otpFocusNodes[0],
                          index: 0,
                          authCubit: authCubit,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: OtpWidget(
                          controller: authCubit.optNum2,
                          focusNode: authCubit.otpFocusNodes[1],
                          index: 1,
                          authCubit: authCubit,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: OtpWidget(
                          controller: authCubit.optNum3,
                          focusNode: authCubit.otpFocusNodes[2],
                          index: 2,
                          authCubit: authCubit,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: OtpWidget(
                          controller: authCubit.optNum4,
                          focusNode: authCubit.otpFocusNodes[3],
                          index: 3,
                          authCubit: authCubit,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: OtpWidget(
                          controller: authCubit.optNum5,
                          focusNode: authCubit.otpFocusNodes[4],
                          index: 4,
                          authCubit: authCubit,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: OtpWidget(
                          controller: authCubit.optNum6,
                          focusNode: authCubit.otpFocusNodes[5],
                          index: 5,
                          authCubit: authCubit,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
                CustomButton(
                  label: "Send",
                  height: 52,
                  width: 327,
                  function: () async {
                    authCubit.otp = authCubit.optNum1.text.trim() + authCubit.optNum2.text.trim() + authCubit.optNum3.text.trim() + authCubit.optNum4.text.trim() + authCubit.optNum5.text.trim() + authCubit.optNum6.text.trim();
                    authCubit.forgetPasswordSendOtp(email: authCubit.email.trim(),
                     otp: authCubit.otp.trim());
                  },
                ),
              ],
            ),
          );
        },
      );
  }
}
