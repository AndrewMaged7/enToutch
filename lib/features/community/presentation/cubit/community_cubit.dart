// import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:en_touch/core/api/end_points.dart';
import 'package:en_touch/core/services/app_services.dart';
import 'package:en_touch/features/community/data/models/add_comment_model.dart';
import 'package:en_touch/features/community/data/models/get_comment_model.dart';
import 'package:en_touch/features/community/data/models/get_post_model.dart';
import 'package:en_touch/features/community/data/models/my_friends_model.dart';
import 'package:en_touch/features/community/data/models/pending_model.dart';
import 'package:en_touch/features/community/data/models/text_to_sign_model.dart';
import 'package:en_touch/features/community/domain/use_cases/add_comment_use_case.dart';
import 'package:en_touch/features/community/domain/use_cases/add_friend_use_case.dart';
import 'package:en_touch/features/community/domain/use_cases/add_like_use_case.dart';
import 'package:en_touch/features/community/domain/use_cases/add_post_use_case.dart';
import 'package:en_touch/features/community/domain/use_cases/comment_with_record_use_case.dart';
import 'package:en_touch/features/community/domain/use_cases/get_comment_use_case.dart';
import 'package:en_touch/features/community/domain/use_cases/get_friends_use_case.dart';
import 'package:en_touch/features/community/domain/use_cases/get_pending_use__case.dart';
import 'package:en_touch/features/community/domain/use_cases/get_post_use_case.dart';
import 'package:en_touch/features/community/domain/use_cases/text_to_sign_use_case.dart' show TextToSignUseCase;
import 'package:flutter/material.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
part 'community_state.dart';

class CommunityCubit extends Cubit<CommunityState> {
  CommunityCubit() : super(CommunityInitial());
  AddPostUseCase addPostUseCase = AddPostUseCase();
  GetPostUseCase getPostUseCase = GetPostUseCase();
  AddCommentUseCase addCommentUseCase = AddCommentUseCase();
  GetCommentUseCase getCommentUseCase = GetCommentUseCase();
  TextToSignUseCase textToSignUseCase = TextToSignUseCase();
  FriendRequestUseCase friendRequestUseCase = FriendRequestUseCase();
  GetPendingUseCase getPendingUseCase = GetPendingUseCase();
  TextToSignModel? textToSignModel;
   String? videoUrl;
   String? lastVideo;
  AddLikeUseCase addLikeUseCase = AddLikeUseCase();
  GetFriendsUseCase getFriendsUseCase = GetFriendsUseCase();
  CommentWithRecordUseCase commentWithRecordUseCase =
      CommentWithRecordUseCase();

  EndPoints endpoint = EndPoints();

  TextEditingController commentController = TextEditingController();
  TextEditingController textToSignController = TextEditingController();
  final Map<String, VideoPlayerController> videoControllers = {};
  AppServices appServices = AppServices();
  String commentWithRecordText = '';
  List<GetPostModel> posts = [];
  List<AddCommentModel> addComments = [];
  List<GetCommentModel> getComment = [];
  List<GetFriendsModel> friends = [];
  List<PendingModel> requests = [];
  bool postText = false;


  

  Future<void> addPost({
    required String content,
    String? mediaUrl,
    String? mediaType,
  }) async {
    emit(PostSLoading());
    try {
      await addPostUseCase(
        content: content,
        mediaUrl: mediaUrl,
        mediaType: mediaType,
      );
      emit(PostSuccess());
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }


  Future<void> getPost() async {
    emit(PostSLoading());
    try {
      posts = await getPostUseCase();
      emit(PostSuccess());
    } catch (e) {
      emit(PostError(e.toString()));
      throw Exception(e.toString());
    }
  }
//   Future<void> getPost() async {
//   emit(PostSLoading());
//   try {
//     posts = await getPostUseCase();
//     for (final post in posts) {
//       if (post.mediaType == "video" && post.mediaUrl != null) {
//         if (!videoControllers.containsKey(post.mediaUrl)) {
//           final controller = VideoPlayerController.networkUrl(
//             Uri.parse(post.mediaUrl!),
//           );
//           await controller.initialize();
//           videoControllers[post.mediaUrl!] = controller;
//         }
//       }
//     }
    
//     emit(PostSuccess());
//   } catch (e) {
//     emit(PostError(e.toString()));
//     throw Exception(e.toString());
//   }
// }

  Future<void> addLike({required String postId}) async {
    try {
      int index = posts.indexWhere((post) => post.id == postId);
      if (index != -1) {
        if (posts[index].isLikedByMe == true) {
          posts[index].likesCount = (posts[index].likesCount ?? 0) - 1;
          posts[index].isLikedByMe = false;
        } else {
          posts[index].likesCount = (posts[index].likesCount ?? 0) + 1;
          posts[index].isLikedByMe = true;
        }
        emit(PostSuccess());
      }
      await addLikeUseCase(postId: postId);
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> addComment({
    required String postId,
    required String content,
  }) async {
    if (content.trim().isEmpty) return;
    try {
      await addCommentUseCase(postId: postId, content: content);
      final List<GetCommentModel> comments = await getCommentUseCase(postId: postId);
        getComment = comments;
      emit(AddCommentSuccess());
    } catch (e) {
      emit(AddCommentError(e.toString()));
    }
  }

  VideoPlayerController? getVideoController(String videoUrl) {
    return videoControllers[videoUrl];
  }

  Future<void> getComments({required String postId}) async {
    emit(GetCommentLoading());
    try {
      final comments = await getCommentUseCase(
      postId: postId,
    );
    getComment = comments;
      emit(GetCommentSuccess());
    } catch (e) {
      emit(GetCommentError(e.toString()));
    }
  }

  Future<void> commentWithRecord(String postId) async {
    emit(RecordCommentLoading());
    try {
      String? comment = await commentWithRecordUseCase.call();
      if (comment != null) {
        commentWithRecordText = comment;
      }
      emit(RecordCommentSuccess());
    } catch (e) {
      emit(RecordCommentError(e.toString()));
    }
  }







//   Future<void> chooseVideoFromGallery({required String content}) async {
//   try {
//     final List<dynamic> videos = await appServices.chooseVideoFromGallery();
//     if (videos.isEmpty) return;

//     emit(PostSLoading());

//     for (final video in videos) {
//       String uploadedPath = await appServices.uploadToServer((video as File).path);
//       await addPostUseCase(
//         content: content,
//         mediaType: "video",
//         mediaUrl: uploadedPath,
//       );
//     }

//     emit(PostSuccess());
//   } catch (e) {
//     emit(PostError(e.toString()));
//   }
// }

  Future<void> chooseVideoFromGallery({required String content}) async {
  try {
    final String? videoPath = await appServices.chooseVideoFromGallery();
    if (videoPath == null) return;

    emit(PostSLoading());
    String uploadedPath = await appServices.uploadToServer(videoPath);
    await addPostUseCase(
      content: content,
      mediaType: "video",
      mediaUrl: uploadedPath,
    );
    emit(PostSuccess());
  } catch (e) {
    emit(PostError(e.toString()));
  }
}

Future<void> startVideoFromCamera({required String content}) async {
    try {
      final String? videoPath = await appServices.startVideoFromCamera();
      if (videoPath == null) return;
      emit(PostSLoading());
        String uploadedPath = await appServices.uploadToServer(videoPath);
        await addPostUseCase(
          content: content,
          mediaType: "video",
          mediaUrl: uploadedPath,
        );
        emit(PostSuccess());
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }


  Future<void> sendPic({required String content}) async {
    emit(PostSLoading());
    try {
      String? imagePath = await appServices.chooseImage();
      if (imagePath != null) {
        String uploadedPath = await appServices.uploadToServer(imagePath);
        await addPostUseCase(
          content: content,
          mediaType: "image",
          mediaUrl: uploadedPath,
        );
        emit(PostSuccess());
      }
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> playVideo(String videoUrl) async {
    if (videoControllers.containsKey(videoUrl)) {
      final existing = videoControllers[videoUrl]!;
      if (existing.value.isPlaying) {
        await existing.pause();
      } else {
        await existing.play();
      }
      if (isClosed) return;
      emit(PostSuccess());
      return;
    }
    emit(PostSLoading());
    try {
      final controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      await controller.initialize();
      await controller.play();
      videoControllers[videoUrl] = controller;
      if (isClosed) return;
      emit(PostSuccess());
    } catch (e) {
      if (isClosed) return;
      emit(PostError(e.toString()));
    }
  }

  Future<void> initVideo(String content) async {
    if (videoControllers.containsKey(content)) {
      final controller = videoControllers[content]!;
      controller.value.isPlaying
          ? await controller.pause()
          : await controller.play();
      emit(PostSuccess());
      return;
    }
  }


  void displayFormField(){
    postText = !postText;
    emit(DisplaySuccess());
  }


  Future<void> sendText(String text) async {
    emit(PostSLoading());
    try {
      textToSignModel = await textToSignUseCase.sendText(text);
      videoUrl = "${endpoint.showVideos}${textToSignModel?.outputVideoUrl}";
        await addPostUseCase(
          content: text,
          mediaType: "video",
          mediaUrl: videoUrl,
        );
      emit(PostSuccess());
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }


  Future<void> sendRequest(String userId) async {
    emit(SendRequestLoading());
    try {
      await friendRequestUseCase.call(userId);
      emit(SendRequestSuccess());
    } catch (e) {
      emit(SendRequestError(e.toString()));
      throw Exception(e.toString());
    }
  }

  Future<void> getFriends() async {
    emit(GetFriendsLoading());
    try {
      friends = await getFriendsUseCase.call();
      emit(GetFriendsSuccess());
    } catch (e) {
      emit(GetFriendsError(e.toString()));
      throw Exception(e.toString());
    }
  }



  Future<void> getPending() async {
    emit(PendingLoading());
    try {
      List<PendingModel> response = await getPendingUseCase.call();
      requests = response;
      if(requests.isEmpty){
        emit(PendingEmpty());
        return;
      }
      emit(PendingSuccess());
    } catch (e) {
      emit(PendingError(e.toString()));
      throw Exception(e.toString());
    }
  } 


  Future<void> saveToDevice(String url) async {
  emit(SaveLoading());
  try {
    final dir = await getTemporaryDirectory();
    final filePath =
        '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';
    await Dio().download(url, filePath);
     await ImageGallerySaverPlus.saveFile(filePath);
    emit(SaveSuccess());
  } catch (e) {
    emit(SaveError(e.toString()));
  }
}
}
