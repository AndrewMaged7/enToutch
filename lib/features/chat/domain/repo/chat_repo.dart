import 'package:en_touch/features/chat/data/models/message_class.dart';
import 'package:en_touch/features/chat/data/models/text_to_sign_chat_model.dart';
import 'package:video_player/video_player.dart';

abstract class ChatRepository {

  Future connectWithSignalR();
  Future sendMessage({required String receiverId, required String content, required String messageType,String mediaUrl});
  void receiveMessage(Function(MessageModel message) callback);
  Future<List<MessageModel>> getChatConversations(String userID);
  Future<VideoPlayerController> playVideo(String videoPath);
  Future<String> getMessageToken();
  Future<void> setSettings();
  Future<void> foregroundNotification();
  Future<void> setPermissions();
  Future<TextToSignChatModel> sendText(String text);
}