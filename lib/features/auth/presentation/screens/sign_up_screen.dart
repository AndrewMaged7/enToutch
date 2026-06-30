import 'package:easy_localization/easy_localization.dart';
import 'package:en_touch/core/routes/routes.dart';
import 'package:en_touch/core/widgets/custom_button.dart';
import 'package:en_touch/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:en_touch/features/auth/presentation/widgets/form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {

  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthCubit authCubit = AuthCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.sp),
        child: BlocConsumer<AuthCubit, AuthState>(
          bloc: authCubit,
          listener: (context, state) {
            if (state is AuthRegisterSuccessState) {
              Navigator.pushNamed(context, Routes.main);
            }
          },
          builder: (context, state) {
            if (state is AuthRegisterLoadingState) {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            } else if (state is AuthRegisterErrorState) {
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
                        Navigator.pushNamed(context, Routes.signUp);
                      },
                    ),
                  ],
                ),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 70.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "auth.signUp".tr(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Form(
                    key: authCubit.signupFormKey,
                    child: Column(
                      children: [
                        FormFieldWidget(
                          label: "auth.fullName".tr(),
                          controller: authCubit.signupFullName,
                          authCubit: authCubit,
                          obSecure: false,
                        ),
                        SizedBox(height: 30.h),
                        FormFieldWidget(
                          label: "auth.email".tr(),
                          controller: authCubit.signupEmail,
                          authCubit: authCubit,
                          obSecure: false,
                        ),
                        SizedBox(height: 30.h),
                        FormFieldWidget(
                          label: "auth.password".tr(),
                          controller: authCubit.signupPassword,
                          authCubit: authCubit,
                          obSecure: authCubit.signupObscure,
                        ),
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.h),
                  SwitchListTile(
                    title: const Text('Deaf and Mute'),
                    value: authCubit.deafAndMute,
                    onChanged: (value) {
                      setState(() {
                        authCubit.deafAndMute = value;
                      });
                    },
                  ),
                  SizedBox(height: 50.h),
                  CustomButton(
                    label: "auth.signUp".tr(),
                    height: 52,
                    width: 327,
                    function: () {
                      if (authCubit.signupFormKey.currentState!.validate()) {
                        authCubit.signUpWithEmailAndPassword(
                          fullName: authCubit.signupFullName.text.trim(),
                          email: authCubit.signupEmail.text.trim(),
                          password: authCubit.signupPassword.text.trim(),
                          isDeaf: authCubit.deafAndMute,
                          isMute: authCubit.deafAndMute,
                        );
                      }
                    },
                  ),
                  SizedBox(height: 40.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "auth.alreadyHaveAccount".tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        InkWell(
                          onTap: () =>
                              Navigator.pushNamed(context, Routes.signIn),
                          child: Text(
                            "auth.login".tr(),
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
