import 'package:easy_localization/easy_localization.dart';
import 'package:en_touch/core/cache/hive_cach_helper.dart';
import 'package:en_touch/core/routes/routes.dart';
import 'package:en_touch/core/widgets/video_player_widget.dart';
import 'package:en_touch/features/auth/data/models/auth_model.dart';
import 'package:en_touch/features/community/presentation/cubit/community_cubit.dart';
import 'package:en_touch/features/community/presentation/widgets/bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Post extends StatelessWidget {
  Post({super.key, required this.communityCubit, required this.index});
  final AuthModel? authModel = HiveCacheHelper.getData<AuthModel>('authData');
  final CommunityCubit communityCubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    final isFriend = communityCubit.friends.any(
      (friend) => friend.id == communityCubit.posts[index].userId,
    );

    final isPending = communityCubit.requests.any(
      (request) => request.id == communityCubit.posts[index].userId,
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.w),
      child: Column(
        children: [
          SizedBox(height: 10.h),
          Row(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundImage: AssetImage("images/img_profile.png"),
              ),
              SizedBox(width: 15.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    communityCubit.posts[index].userFullName ??
                        "userFullName is null",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    authModel?.isDeaf == true && authModel!.isMute == true
                        ? "Deaf And Mute"
                        : "Normal",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.chats,
                    arguments:
                        communityCubit.posts[index].userId ?? "userId is null",
                  );
                   HiveCacheHelper.saveData<String>(
                    'receiverName',
                    communityCubit.posts[index].userFullName ??
                        "fullName is null",
                  );
                },
                child: authModel?.id == communityCubit.posts[index].userId? Text("") : Image.asset(
                  "images/message_icon.png",
                  width: 20.w,
                  height: 18.h,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              SizedBox(width: 15.w),
              InkWell(
                onTap: () {
                  communityCubit.saveToDevice(
                    communityCubit.posts[index].mediaUrl ?? "media is null",
                  );
                },
                child: Icon(Icons.download, color: Theme.of(context).iconTheme.color),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Align(
            alignment: Alignment.centerLeft,
            child: communityCubit.posts[index].mediaType == "image"
                ? Container(
                    width: 320.w,
                    height: 162.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Image.network(
                      communityCubit.posts[index].mediaUrl ?? "media is null",
                      fit: BoxFit.cover,
                    ),
                  )
                : communityCubit.posts[index].mediaType == "video"
                ? GestureDetector(
                    onTap: () {
                      communityCubit.playVideo(
                        communityCubit.posts[index].mediaUrl ?? "media is null",
                      );
                    },
                    child: Container(
                      width: 320.w,
                      height: 162.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: VideoPlayerWidget(
                        videoPlayerController: communityCubit
                            .getVideoController(
                              communityCubit.posts[index].mediaUrl ??
                                  "media is null",
                            ),
                      ),
//                       child: Builder(
//   builder: (context) {
//     final controller = communityCubit.getVideoController(
//       communityCubit.posts[index].mediaUrl ?? "",
//     );
//     if (controller == null || !controller.value.isInitialized) {
//       return Container(
//         width: 320.w,
//         height: 162.h,
//         decoration: BoxDecoration(
//           color: Colors.black,
//           borderRadius: BorderRadius.circular(10.r),
//         ),
//         child: Center(
//           child: CircularProgressIndicator(color: Colors.white),
//         ),
//       );
//     }
//     return VideoPlayerWidget(videoPlayerController: controller);
//   },
// ),
                    ),
                  )
                : Text(
                    communityCubit.posts[index].content ?? "content is null",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              InkWell(
                onTap: () {
                  communityCubit.addLike(
                    postId: communityCubit.posts[index].id ?? "id is null",
                  );
                },
                child: communityCubit.posts[index].isLikedByMe ?? false
                    ? Image.asset(
                        "images/fill_heart_icon.png",
                        width: 23.w,
                        height: 23.h,
                        color: Theme.of(context).iconTheme.color,
                      )
                    : Image.asset(
                        "images/heart_icon.png",
                        width: 23.w,
                        height: 23.h,
                        color: Theme.of(context).iconTheme.color,
                      ),
              ),
              SizedBox(width: 10.w),
              Text(
                communityCubit.posts[index].likesCount == 0
                    ? ""
                    : communityCubit.posts[index].likesCount.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(width: 15.w),
              InkWell(
                onTap: () async {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return BottomSheetWidget(
                        communityCubit: communityCubit,
                        postId: communityCubit.posts[index].id ?? "id is null",
                      );
                    },
                  );
                },
                child: Image.asset(
                  "images/comment_icon.png",
                  height: 19.h,
                  width: 20.w,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              SizedBox(width: 15.w),
              InkWell(
                onTap: () async {
                  await communityCubit.commentWithRecord(
                    communityCubit.posts[index].id ?? "id is null",
                  );
                  communityCubit.addComment(
                    postId: communityCubit.posts[index].id ?? "id is null",
                    content: communityCubit.commentWithRecordText,
                  );
                },
                child: BlocBuilder<CommunityCubit, CommunityState>(
                  bloc: communityCubit,
                  builder: (context, state) {
                    return Image.asset(
                      "images/mic_icon.png",
                      height: state is RecordCommentLoading ? 25.h : 21.h,
                      width: state is RecordCommentLoading ? 19.w : 15.w,
                      color: state is RecordCommentLoading
                          ? Colors.green
                          : Theme.of(context).iconTheme.color,
                    );
                  },
                ),
              ),
              Spacer(),
              authModel?.id == communityCubit.posts[index].userId
                  ? Text("")
                  : isFriend
                  ? Text(
                      "friends",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ) : 
                    isPending
                  ? Text(
                      "pending",
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  : InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Friend request sent to ${communityCubit.posts[index].userFullName}",
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "home.addFriend".tr(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
              SizedBox(width: 10.w),
            ],
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
