// import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:en_touch/core/cache/hive_cach_helper.dart';
import 'package:en_touch/core/services/app_services.dart';
import 'package:en_touch/features/auth/data/models/auth_model.dart';
import 'package:en_touch/features/chat/data/models/message_class.dart';
import 'package:en_touch/features/chat/data/repo/chat_repo_impl.dart';
import 'package:en_touch/features/chat/domain/repo/chat_repo.dart';
import 'package:en_touch/features/chat/domain/use%20case/connect_chat_use_case.dart';
import 'package:en_touch/features/chat/domain/use%20case/get_chat_conversation.dart';
import 'package:en_touch/features/chat/domain/use%20case/send_message_use_case.dart';
import 'package:en_touch/features/chat/domain/use%20case/listen_to_message_use_case.dart';
import 'package:en_touch/features/chat/domain/use%20case/text_to_sign_chst_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:video_player/video_player.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(MessageLoading());

  SendMessagesUseCase sendMessagesUseCase = SendMessagesUseCase();
  GetChatConversation getChatConversationUseCase = GetChatConversation();
  ConnectChatUseCase connectUseCase = ConnectChatUseCase();
  ListenToMessagesUseCase listenUseCase = ListenToMessagesUseCase();
  TextToSignChatUseCase textToSignChatUseCase = TextToSignChatUseCase();
  final Map<String, VideoPlayerController> videoControllers = {};
  List<MessageModel> messages = [];
  AppServices appServices = AppServices();
  String? videoPath;
  String? imagePath;
  String error = "";
  String? receiverId; 
  ChatRepository repository = ChatRepoImpl();
  final ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  final AuthModel? userModel = HiveCacheHelper.getData<AuthModel>("authData");

  Future<void> connect() async {
    await connectUseCase.connect();
    listenUseCase((message) {
      messages.add(message);
      emit(MessageSuccess());
    });
  }

  Future<void> sendText(String receiverId, String content) async {
    await sendMessagesUseCase.call(
      receiverId: receiverId,
      content: content,
      messageType: "text",
    );
    final message = MessageModel(
      senderId: userModel?.id ?? "",
      receiverId: receiverId,
      content: content,
      messageType: "text",
    );
    messages.add(message);
    emit(MessageSuccess());
  }



Future<void> sendTextToSign(String receiverId, String content) async {
    final model =  await textToSignChatUseCase.sendText(content);
    String fullPath = "https://entouch.runasp.net/${model.outputVideoUrl}";
    await sendMessagesUseCase.call(
      receiverId: receiverId,
      content: fullPath,
      messageType: "video",
      mediaUrl: fullPath,
    );
    final message = MessageModel(
      senderId: userModel?.id ?? "",
      receiverId: receiverId,
      content: fullPath,
      messageType: "video",
      videoPath: fullPath,
    );
    messages.add(message);
    emit(MessageSuccess());
  }




  Future<void> initVideo(String content) async {
  if (videoControllers.containsKey(content)) {
    final controller = videoControllers[content]!;
    controller.value.isPlaying
        ? await controller.pause()
        : await controller.play();
    emit(PlayVideoSuccess());
    return;
  }
  emit(PlayVideoLoading());
  try {
    final controller = VideoPlayerController.networkUrl(Uri.parse(content));
    await controller.initialize();
    await controller.play();
    videoControllers[content] = controller; 
    emit(PlayVideoSuccess());
  } catch (e) {
    emit(PlayVideoError(e.toString()));
  }
}


//   Future<void> chooseVideoFromGallery(String receiverId) async {
//   try {
//     final List<dynamic> videos = await appServices.chooseVideoFromGallery();
//     if (videos.isEmpty) return;

//     emit(MessageLoading());

//     for (final video in videos) {
//       final String uploadedPath = await appServices.uploadToServer((video as File).path);
//       await sendMessagesUseCase.call(
//         receiverId: receiverId,
//         content: uploadedPath,
//         messageType: "video",
//         mediaUrl: uploadedPath,
//       );
//       messages.add(MessageModel(
//         senderId: userModel?.id ?? "",
//         receiverId: receiverId,
//         content: uploadedPath,
//         videoPath: uploadedPath,
//         messageType: "video",
//       ));
//     }

//     emit(MessageSuccess());
//   } catch (e) {
//     emit(MessageError("Failed to send video: ${e.toString()}"));
//   }
// }
  Future<void> chooseVideoFromGallery(String receiverId) async {
  try {
    final String? videoPath = await appServices.chooseVideoFromGallery();
    if (videoPath == null) return;

    emit(MessageLoading());
    final String uploadedPath = await appServices.uploadToServer(videoPath);
    await sendMessagesUseCase.call(
      receiverId: receiverId,
      content: uploadedPath,
      messageType: "video",
      mediaUrl: uploadedPath,
    );
    messages.add(MessageModel(
      senderId: userModel?.id ?? "",
      receiverId: receiverId,
      content: uploadedPath,
      videoPath: uploadedPath,
      messageType: "video",
    ));
    emit(MessageSuccess());
  } catch (e) {
    emit(MessageError("Failed to send video: ${e.toString()}"));
  }
}


Future<void> startVideoFromCamera(String receiverId, String videoPath) async {
  try {
    final String? video = await appServices.startVideoFromCamera();
    if (video == null || video.isEmpty) {
      return;
    }
    emit(MessageLoading());
    final String uploadedPath = await appServices.uploadToServer(video);
    this.videoPath = uploadedPath;
    await sendMessagesUseCase.call(
      receiverId: receiverId,
      content: uploadedPath,
      messageType: "video",
      mediaUrl: uploadedPath,
    );
    final message = MessageModel(
      senderId: userModel?.id ?? "",
      receiverId: receiverId,
      content: uploadedPath,        
      videoPath: uploadedPath,
      messageType: "video",
    );
    messages.add(message);
    emit(MessageSuccess());
  } catch (e) {
    emit(MessageError("Failed to send video: ${e.toString()}"));
  }
}


VideoPlayerController? getVideoController(String videoUrl) {
  return videoControllers[videoUrl];
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
    emit(PlayVideoSuccess());
    return;
  }
  emit(PlayVideoLoading());
  try {
    final controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    await controller.initialize();
    await controller.play();
    videoControllers[videoUrl] = controller;
    if (isClosed) return;
    emit(PlayVideoSuccess());
  } catch (e) {
    if (isClosed) return;
    error = e.toString();
    emit(PlayVideoError(error));
  }
}

  Future<void> sendImage(String receiverId, String imagePath) async {
  try {
    final String? image = await appServices.chooseImage();
    emit(MessageLoading());
    final String uploadedPath = await appServices.uploadToServer(image!);
    this.imagePath = uploadedPath;
    await sendMessagesUseCase.call(
      receiverId: receiverId,
      content: uploadedPath,
      messageType: "image",
      mediaUrl: uploadedPath,
    );
    final message = MessageModel(
      senderId: userModel?.id ?? "",
      receiverId: receiverId,
      content: uploadedPath,        
      videoPath: uploadedPath,
      messageType: "image",
    );
    messages.add(message);
    emit(MessageSuccess());
  } catch (e) {
    emit(MessageError("Failed to send image: ${e.toString()}"));
  }
}

  // Future<void> getChatConversation(String userID) async {
  //   emit(MessageLoading());
  //   try {
  //     final response = await getChatConversationUseCase.getChatConversation(
  //       userID,
  //     );
  //     messages.addAll(response);
  //     emit(MessageSuccess());
  //   } catch (e) {
  //     emit(MessageError(e.toString()));
  //   }
  // }

  Future<void> getChatConversation(String userID) async {
    emit(MessageLoading());
    try {
      final response = await getChatConversationUseCase.getChatConversation(
        userID,
      );
      messages.addAll(response);
      emit(MessageSuccess());
    } catch (e) {
      emit(MessageError(e.toString()));
    }
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
Future<void> close() {
  for (final controller in videoControllers.values) {
    controller.dispose();
  }
  videoControllers.clear();
  scrollController.dispose();
  return super.close();
}

}
