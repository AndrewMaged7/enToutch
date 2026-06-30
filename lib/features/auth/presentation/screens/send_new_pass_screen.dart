import 'package:en_touch/core/routes/routes.dart';
import 'package:en_touch/core/widgets/custom_button.dart';
import 'package:en_touch/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:en_touch/features/auth/presentation/widgets/form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendNewPassScreen extends StatelessWidget {
  SendNewPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = ModalRoute.of(context)?.settings.arguments as AuthCubit;
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        bloc: authCubit,
        listener: (context, state) {
          if (state is SendNewPassSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Password reset successfully!")),
            );
            Navigator.pushNamed(context, Routes.signIn);
          }
        },
        builder: (context, state) {
          if (state is SendNewPassLoading) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (state is SendNewPassError) {
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
                      Navigator.pushNamed(context, Routes.sendNewPass);
                    },
                  ),
                ],
              ),
            );
          }
          return Column(
            children: [
              SizedBox(height: 114.h),
              Align(
                alignment: AlignmentGeometry.center,
                child: Text(
                  "New Password",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              SizedBox(height: 50.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: FormFieldWidget(
                  authCubit: authCubit,
                  label: "New Password",
                  controller: authCubit.newPass,
                  obSecure: authCubit.newPassObscure,
                ),
              ),
              SizedBox(height: 40.h),
              CustomButton(
                label: "Send",
                height: 52,
                width: 327,
                function: () {
                  authCubit.forgetPasswordSendNewPass(
                    email: authCubit.email.trim(),
                    newPassword: authCubit.newPass.text.trim(),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
