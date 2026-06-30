import 'package:easy_localization/easy_localization.dart';
import 'package:en_touch/core/routes/routes.dart';
import 'package:en_touch/core/widgets/custom_button.dart';
import 'package:en_touch/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:en_touch/features/auth/presentation/widgets/form_field_widget.dart';
import 'package:en_touch/features/auth/presentation/widgets/social_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInScreen extends StatelessWidget {
  final AuthCubit authCubit = AuthCubit();
  SignInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      bloc: authCubit,
      listener: (context, state) async {
        if (state is AuthSignInSuccessState || state is LoginSuccess) {
          await Navigator.pushNamed(context, Routes.main);
        }
      },
      child: Scaffold(
        body: BlocBuilder<AuthCubit, AuthState>(
          bloc: authCubit,
          builder: (context, state) {
            if (state is AuthSignInLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AuthSignInErrorState) {
              return Center(
                child: Text(state.message),
              );
            }
            return Padding(
              padding: EdgeInsets.all(20.sp),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 70.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "auth.login".tr(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    Form(
                      key: authCubit.signinFormKey,
                      child: Column(
                        children: [
                          SizedBox(height: 20.h),
                          FormFieldWidget(
                            label: "auth.email".tr(),
                            controller: authCubit.signinEmail,
                            authCubit: authCubit,
                            obSecure: false,
                          ),
                          SizedBox(height: 20.h),
                          FormFieldWidget(
                            label: "auth.password".tr(),
                            controller: authCubit.signinPassword,
                            authCubit: authCubit,
                            obSecure: authCubit.signinObscure,
                          ),
                          SizedBox(height: 30.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  Routes.forgetPass,
                                ),
                                child: Text(
                                  "auth.forgetPassword".tr(),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 70.h),
                          CustomButton(
                            label: "auth.login".tr(),
                            height: 52,
                            width: 327,
                            function: () {
                              if (authCubit.signinFormKey.currentState!
                                  .validate()) {
                                authCubit.signInWithEmailAndPassword(
                                  email: authCubit.signinEmail.text.trim(),
                                  password: authCubit.signinPassword.text
                                      .trim(),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30.h),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1.h,
                            width: 112.w,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          "auth.orSignInWith".tr(),
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Container(
                            height: 1.h,
                            width: 112.w,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            authCubit.signInWithGoogle();
                          },
                          child: SocialIconWidget(
                            imgUrl: "images/google_img.png",
                          ),
                        ),
                        SizedBox(width: 50.w),
                        InkWell(
                          child: SocialIconWidget(
                            imgUrl: "images/face_book_img.png",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "auth.noAccount".tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        InkWell(
                          onTap: () =>
                              Navigator.pushNamed(context, Routes.signUp),
                          child: Text(
                            "auth.signUp".tr(),
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
              ),
            );
          },
        ),
      ),
    );
  }
}
