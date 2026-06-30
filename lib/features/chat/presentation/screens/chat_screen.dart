import 'package:en_touch/core/cache/hive_cach_helper.dart';
import 'package:en_touch/features/auth/data/models/auth_model.dart';
import 'package:en_touch/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:en_touch/features/chat/presentation/widgets/messsage_type.dart';
import 'package:en_touch/features/chat/presentation/widgets/send_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:en_touch/core/routes/routes.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatCubit chatCubit = ChatCubit();
  String receveirId = "";
  @override
void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      receveirId =
          ModalRoute.of(context)?.settings.arguments as String? ?? "";
      await chatCubit.connect();
      chatCubit.getChatConversation(receveirId);
      setState(() {});
    });
  }

  @override
  void dispose() {
    chatCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String senderId = HiveCacheHelper.getData<AuthModel>('authData')?.id ?? "";
    String receiverName = HiveCacheHelper.getData<String>('receiverName') ?? "";
    // String receiverNameFromSearch = HiveCacheHelper.getData<String>('chatUserName') ?? "";
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverName),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Image.asset(
              "images/history_icon.png",
              color: Theme.of(context).iconTheme.color,
              width: 29.w,
              height: 27.h,
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.homeChats);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                bloc: chatCubit,
                listener: (context, state) {
                  if (state is MessageSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      chatCubit.scrollToBottom();
                    });
                  }
                },
                builder: (context, state) {
                  if (state is MessageLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  else if (state is MessageError) {
                    return Center(child: Text(state.message));
                  }

                  else if (chatCubit.messages.isEmpty) {
                    return const Center(child: Text("No messages yet"));
                  }

                  return ListView.builder(
                    controller: chatCubit.scrollController,
                    itemCount: chatCubit.messages.length,
                    itemBuilder: (context, index) {
                      final message = chatCubit.messages[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child:
                            message.senderId == senderId
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: MessageType(
                                  content: message.content ?? "",
                                  messageType: message.messageType ?? "",
                                  color: Colors.grey.shade200,
                                  index: index,
                                  chatCubit: chatCubit,
                                ),
                              )
                            : Align(
                                alignment: Alignment.centerLeft,
                                child: MessageType(
                                  content: message.content ?? "",
                                  color: Colors.blue.shade200,
                                  index: index,
                                  messageType: message.messageType ?? "",
                                  chatCubit: chatCubit,
                                ),
                              ),
                      );
                    },
                  );
                },
              ),
            ),
            // Spacer(),
            SizedBox(height: 10.h),
            SendMessageWidget(chatCubit: chatCubit, receveirId: receveirId),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
