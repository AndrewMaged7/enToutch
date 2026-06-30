import 'package:easy_localization/easy_localization.dart';
import 'package:en_touch/core/colors/app_colors.dart';
import 'package:en_touch/core/routes/routes.dart';
import 'package:en_touch/core/widgets/advanced_btn.dart';
import 'package:en_touch/core/widgets/custom_button.dart';
import 'package:en_touch/core/widgets/custom_text_form_field.dart';
import 'package:en_touch/features/camera/presentation/cubit/camera_cubit.dart';
import 'package:en_touch/features/result/presentation/screen/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnswerScreen extends StatelessWidget {
  AnswerScreen({super.key});
  final CameraCubit cameraCubit = CameraCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.main);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        title: Text('camera.yourAnswer'.tr()),
      ),
      body: BlocBuilder<CameraCubit, CameraState>(
        bloc: cameraCubit,
        builder: (context, state) {
          if(state is SendResultLoading){
          return Center(child: CircularProgressIndicator());
        } else if(state is SendResultError){
          return Center(child: Text(cameraCubit.error));
        }
        if(state is SendResultSuccess){
          WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ResultScreen(
              videoPath: cameraCubit.resultVideoPath!,
              resultText: cameraCubit.resultText!,
            ),
          ),
        );
      });

        }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30.h),
              Text(
                "camera.answerWith".tr(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      cameraCubit.chooseAnswerType("text");
                    },
                    child: AdvancedBtn(
                      img: "images/text_icon.png",
                      label_1: "camera.text".tr(),
                      label_2: "",
                      width: 100,
                      height: 98,
                      imgHeight: 26,
                      imgWidth: 32,
                    ),
                  ),
                  SizedBox(width: 30.w),
                  InkWell(
                    onTap: () {
                      cameraCubit.chooseAnswerType("audio");
                    },
                    child: AdvancedBtn(
                      img: "images/mic_icon.png",
                      label_1: "camera.audio".tr(),
                      label_2: "",
                      width: 100,
                      height: 98,
                      imgHeight: 24,
                      imgWidth: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              cameraCubit.answerTYPE == 'text'
                  ? Column(
                      children: [
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "images/text_icon.png",
                              height: 40.h,
                              width: 40.w,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            SizedBox(width: 10.w),
                            Container(
                              height: 40.h,
                              width: 230.w,
                              child: CustomTextFormField(
                                controller:
                                    cameraCubit.sendResultTextController,
                                label: "camera.typing".tr(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomButton(
                              label: "camera.clickToSign".tr(),
                              height: 62,
                              width: 202,
                              borderRadius: 8,
                              function: () {
                                cameraCubit.sendResultText(
                                  cameraCubit.sendResultTextController.text,
                                );
                              },
                            ),
                            SizedBox(width: 30.w),
                          ],
                        ),
                      ],
                    )
                  : cameraCubit.answerTYPE == 'audio'
                  ? Column(
                      children: [
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 10.w),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    cameraCubit.sendResultAudio();
                                  },
                                  child: Image.asset(
                                    "images/mic_icon.png",
                                    height: 30.h,
                                    width: 30.w,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Container(
                                  width: 230.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: AppColors.buttonColor,
                                      width: 2.w,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    cameraCubit.recordedAnswer.isEmpty
                                        ? ""
                                        : cameraCubit.recordedAnswer,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 40.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomButton(
                              label: "camera.clickToSign".tr(),
                              height: 62,
                              width: 202,
                              borderRadius: 8,
                              function: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.resultScreen,
                                );
                              },
                            ),
                            SizedBox(width: 30.w),
                          ],
                        ),
                      ],
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }
}
