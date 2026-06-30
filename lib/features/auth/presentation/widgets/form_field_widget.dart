import 'package:en_touch/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obSecure;
  FormFieldWidget({
    super.key,
    required this.label,
    required this.controller,
    required this.obSecure,
    required this.authCubit,
  });
  final AuthCubit authCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      bloc: authCubit,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
            ),
            SizedBox(height: 10.h),
            TextFormField(
              controller: controller,
              decoration: InputDecoration(
                suffixIcon: label == "Password" || label == "Confirm Password" || label == "New Password"
                    ? IconButton(
                        color: Theme.of(context).iconTheme.color,
                        icon: Icon(
                          obSecure
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          authCubit.signinSecure();
                          authCubit.signupSecurePass();
                          authCubit.signupConfirmPasswordToggle();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
              obscureText: obSecure,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'required';
                }
                return null;
              },
            ),
          ],
        );
      },
    );
  }
}
