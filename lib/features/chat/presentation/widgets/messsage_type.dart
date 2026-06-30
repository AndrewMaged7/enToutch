import 'package:en_touch/core/widgets/video_player_widget.dart';
import 'package:en_touch/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageType extends StatelessWidget {
  const MessageType({
    super.key,
    required this.content,
    required this.color,
    required this.index,
    required this.messageType,
    required this.chatCubit,
  });

  final String content;
  final String messageType;
  final Color color;
  final int index;
  final ChatCubit chatCubit;

 @override
  Widget build(BuildContext context) {
    if (messageType == "text") {
      return Text(content);
    }

    if (messageType == "image") {
      return SizedBox(
        width: 200.w,
        height: 150.h,
        child: Image.network(content, fit: BoxFit.cover),
      );
    }

    if (messageType == "video") {
      return BlocBuilder<ChatCubit, ChatState>(
        bloc: chatCubit,
        buildWhen: (prev, curr) =>
            curr is PlayVideoSuccess ||
            curr is PlayVideoLoading ||
            curr is PlayVideoError,
        builder: (context, state) {
          final controller = chatCubit.getVideoController(content);
          return GestureDetector(
            onTap: () => chatCubit.playVideo(content),
            child: VideoPlayerWidget(
              videoPlayerController: controller, 
            ),
          );
        },
      );
    }

    return const SizedBox();
  }
}