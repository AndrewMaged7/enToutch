import 'package:en_touch/core/routes/routes.dart';
import 'package:en_touch/core/widgets/custom_button.dart';
import 'package:en_touch/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:en_touch/features/auth/presentation/widgets/form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPassScreen extends StatelessWidget {
  ForgetPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is SendEmailSuccess) {
              final authCubit = context.read<AuthCubit>();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Email sent successfully! Please check your inbox.",
                  ),
                ),
              );
              Navigator.pushNamed(
                context,
                Routes.sendOtp,
                arguments: authCubit,
              );
            }
          },
          builder: (context, state) {
            final authCubit = context.read<AuthCubit>();
            if (state is SendEmailLoading) {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            } else if (state is SendEmailError) {
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
                        Navigator.pushNamed(context, Routes.forgetPass);
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
                    "Forget Password",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                SizedBox(height: 50.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Form(
                    key: authCubit.forgetPassSendEmailFormKey,
                    child: FormFieldWidget(
                      authCubit: authCubit,
                      label: "Email",
                      controller: authCubit.forgetPassSendEmail,
                      obSecure: false,
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                CustomButton(
                  label: "Send",
                  height: 52,
                  width: 327,
                  function: () async {
                    if (authCubit.forgetPassSendEmailFormKey.currentState!
                        .validate()) {
                      authCubit.forgetPasswordSendEmail(
                        email: authCubit.forgetPassSendEmail.text.trim(),
                      );
                      authCubit.email = authCubit.forgetPassSendEmail.text.trim();
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
