import 'package:en_touch/core/routes/routes.dart';
import 'package:en_touch/core/widgets/custom_dialog.dart';
import 'package:en_touch/features/community/presentation/cubit/community_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});
  final CommunityCubit communityCubit = CommunityCubit();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityCubit, CommunityState>(
      bloc: communityCubit,
      builder: (context, state) {
        if (state is PostSLoading) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (state is PostError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () => Navigator.pushNamed(context, Routes.main),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Row(
                  children: [
                    Text(
                      "What is on your mind?",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Spacer(),
                    Icon(
                      Icons.camera_alt,
                      color: Theme.of(context).iconTheme.color,
                      size: 30.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: InkWell(
                  onTap: () =>
                      communityCubit.sendPic(content: "Your image description"),
                  child: Text(
                    "Add Image",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              SizedBox(height: 50.h),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: InkWell(
                  onTap: () {
                    showDialog(
                    context: context,
                    builder: (_) => CustomDialog(
                      labelOption1: "using camera",
                      labelOption2: "from gallery",
                      option1: () {
                        communityCubit.startVideoFromCamera(content: "Your video description");
                      },
                      option2: () {
                        communityCubit.chooseVideoFromGallery(content: "Your video description");
                      },
                    ),
                  );
                  },
                  child: Text(
                    "Add Sign",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              SizedBox(height: 50.h),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: InkWell(
                  onTap: () => communityCubit.displayFormField(),
                  child: Text(
                    "Add Text To Sign",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              SizedBox(height: 80.h),
              Visibility(
                visible: communityCubit.postText,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Row(
                    children: [
                      Container(
                        width: 250.w,
                        height: 50.h,
                        child: TextField(
                          controller: communityCubit.textToSignController,
                          decoration: InputDecoration(
                            hintText: "Add your text here...",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        onPressed: () {
                          communityCubit.sendText(
                            communityCubit.textToSignController.text,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
