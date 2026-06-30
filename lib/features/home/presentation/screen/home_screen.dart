import 'package:easy_localization/easy_localization.dart';
import 'package:en_touch/core/cache/hive_cach_helper.dart';
import 'package:en_touch/core/routes/routes.dart';
import 'package:en_touch/core/widgets/advanced_btn.dart';
import 'package:en_touch/features/auth/data/models/auth_model.dart';
import 'package:en_touch/features/home/presentation/cubit/home_cubit.dart';
import 'package:en_touch/features/home/presentation/widgets/communication_types.dart';
import 'package:en_touch/features/home/presentation/widgets/slider_widget.dart';
import 'package:en_touch/core/widgets/welcome_message.dart';
import 'package:en_touch/features/inverse%20camera/presentation/screens/result_for_camera_screen.dart';
import 'package:en_touch/features/text%20to%20sign/presentation/cubit/text_to_sign_cubit.dart';
import 'package:en_touch/features/text%20to%20sign/presentation/screen/text_to_sign_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeCubit homeCubit = HomeCubit();

  final AuthModel? userModel = HiveCacheHelper.getData<AuthModel>("authData");

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: homeCubit,
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WelcomeMessage(),
                SizedBox(height: 30.h),
                Row(
                  children: [
                    SizedBox(width: 30.w),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.camera);
                        },
                        child: CommunicationTypes(
                          label: "home.fromSign".tr(),
                          img: "images/camera.png",
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InverseAnswerScreen(),
                            ),
                          );
                        },
                        child: CommunicationTypes(
                          label: "home.toSign".tr(),
                          img: "images/camera.png",
                        ),
                      ),
                    ),
                    SizedBox(width: 30.w),
                  ],
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(context, Routes.community),
                    child: CommunicationTypes(
                      label: "home.communities".tr(),
                      img: "images/community_img.png",
                      fontSize: 20,
                      iconWidth: 35,
                      iconHeight: 35,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 30.w),
                    Text(
                      "home.suggestions".tr(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                SliderWidget(),
                SizedBox(height: 25.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () async {
                        final cubit = TextToSignCubit();
                        final picked = await cubit.pickVideo();
                        if (!picked) return;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                TextToSignScreen(textToSignCubit: cubit),
                          ),
                        );
                      },
                      child: AdvancedBtn(
                        img: "images/book.png",
                        label_1: "home.videoTo".tr(),
                        label_2: "home.sign".tr(),
                      ),
                    ),
                    InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, Routes.learnNewSign),
                      child: AdvancedBtn(
                        img: "images/learn.png",
                        label_1: "home.learnNew".tr(),
                        label_2: "home.sign".tr(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
