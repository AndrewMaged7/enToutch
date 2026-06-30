// import 'package:en_touch/core/widgets/custom_button.dart';
import 'package:en_touch/core/widgets/custom_dialog.dart';
import 'package:en_touch/core/widgets/custom_text_form_field.dart';
import 'package:en_touch/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendMessageWidget extends StatelessWidget {
  SendMessageWidget({
    super.key,
    required this.chatCubit,
    required this.receveirId,
  });
  final ChatCubit chatCubit;
  final String receveirId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatCubit, ChatState>(
      bloc: chatCubit,
      listener: (context, state) {
        if (state is MessageError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: Row(
        children: [
          SizedBox(width: 3.w),
          IconButton(
            onPressed: () {
              chatCubit.sendImage(receveirId, "");
            },
            icon: Icon(Icons.add, size: 30.sp, color: Colors.blueGrey),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: CustomTextFormField(
              controller: chatCubit.messageController,
              label: "Type a message...",
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                color: Colors.blueGrey,
                onPressed: () {
                  if (chatCubit.messageController.text.trim().isEmpty) return;
                  showDialog(
                    context: context,
                    builder: (_) => CustomDialog(
                      labelOption1: "send as text",
                      labelOption2: "send as video",
                      option1: () {
                        chatCubit.sendText(
                          receveirId,
                          chatCubit.messageController.text,
                        );
                        chatCubit.messageController.clear();
                      },
                      option2: () {
                        chatCubit.sendTextToSign(
                          receveirId,
                          chatCubit.messageController.text,
                        );
                        chatCubit.messageController.clear();
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 3.w),
          InkWell(
            onTap: () {
              showDialog(
                    context: context,
                    builder: (_) => CustomDialog(
                      labelOption1: "using camera",
                      labelOption2: "from gallery",
                      option1: () {
                        chatCubit.startVideoFromCamera(receveirId, "");
                      },
                      option2: () {
                        chatCubit.chooseVideoFromGallery(receveirId);
                      },
                    ),
                  );
            },
            child: SizedBox(
              height: 50.h,
              width: 50.w,
              child: Image.asset("images/camera.png"),
            ),
          ),
        ],
      ),
    );
  }
}
