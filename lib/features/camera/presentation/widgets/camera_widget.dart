import 'package:easy_localization/easy_localization.dart';
import 'package:en_touch/core/widgets/custom_dialog.dart';
import 'package:en_touch/core/widgets/welcome_message.dart';
import 'package:en_touch/features/camera/presentation/cubit/camera_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CameraWidget extends StatelessWidget {
  CameraWidget({super.key,required this.cameraCubit});
  final CameraCubit cameraCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraCubit, CameraState>(
      bloc: cameraCubit,
      builder: (context, state) {
        if (state is SendVideoLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SendVideoError) {
          return Center(child: Text("Error sending video: ${state.error}"));
        }
        return Column(
          children: [
            WelcomeMessage(),
            SizedBox(height: 50.h),
            Container(
              height: 315.h,
              width: 259.w,
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).iconTheme.color!, width: 2.w),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/camera.png",
                    height: 44.h,
                    width: 51.w,
                    color: Theme.of(context).iconTheme.color,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "home.useCamera".tr(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.h),
            InkWell(
              onTap: state is SendVideoLoading
                  ? null
                  : () {
                      showDialog(
                    context: context,
                    builder: (_) => CustomDialog(
                      labelOption1: "using camera",
                      labelOption2: "from gallery",
                      option1: () {
                        cameraCubit.startVideoFromCamera();
                      },
                      option2: () {
                        cameraCubit.chooseVideoFromGallery();
                      },
                    ),
                  );
                    },
              child: Image.asset('images/camera_btn.png'),
            ),
          ],
        );
      },
    );
  }
}
