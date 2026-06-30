import 'package:easy_localization/easy_localization.dart';
import 'package:en_touch/core/routes/routes.dart';
import 'package:en_touch/features/community/presentation/cubit/community_cubit.dart';
import 'package:en_touch/features/community/presentation/widgets/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Community extends StatelessWidget {
  Community({super.key});
  final CommunityCubit communityCubit = CommunityCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Navigator.pushNamed(context, Routes.main),
        ),
        title: Text("home.communities".tr()),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Image.asset(
              "images/community_img.png",
              width: 35.w,
              height: 35.h,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CommunityCubit, CommunityState>(
              bloc: communityCubit..getPost()..getFriends()..getPending(),
              builder: (context,state){
                if (state is PostSLoading) {
                  Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: communityCubit.posts.length,
                itemBuilder: (context, index) =>
                    Post(communityCubit: communityCubit, index: index),
              );
              }
            ),
          ),
        ],
      ),
    );
  }
}
