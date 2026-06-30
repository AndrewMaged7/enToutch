import 'package:en_touch/core/widgets/custom_text_form_field.dart';
import 'package:en_touch/features/community/presentation/cubit/community_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({
    required this.communityCubit, required this.postId,
  });
  final CommunityCubit communityCubit;
  final String postId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 20.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
      ),
      child: SizedBox(
        height: 550.h,
        child: Column(
          children: [
            Container(
              width: 60.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            SizedBox(height: 20.h),
            Text("Comments", style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: 5.h),
            Expanded(
              child: BlocBuilder<CommunityCubit, CommunityState>(
                bloc: communityCubit..getComments(postId: postId),
                builder: (context, state) {
                  if (state is GetCommentLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is GetCommentError) {
                    return Center(child: Text(state.message));
                  }
                  return ListView.builder(
                    itemCount: communityCubit.getComment.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15.h),
                          Text(
                            communityCubit.getComment[index].userFullName!,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            communityCubit.getComment[index].content!,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    controller: communityCubit.commentController,
                    label: "Type a comment...",
                  ),
                ),
                SizedBox(width: 10.w),
                IconButton(
                  icon: Icon(Icons.send,color: Theme.of(context).iconTheme.color,),
                  color: Colors.blueGrey,
                  onPressed: () {
                    if (communityCubit.commentController.text.trim().isEmpty)
                      return;
                    communityCubit.addComment(
                        postId: postId,
                      content: communityCubit.commentController.text,
                    );
                    communityCubit.commentController.clear();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
