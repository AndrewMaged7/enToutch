
import 'package:en_touch/features/chat/data/repo/chat_repo_impl.dart';
import 'package:en_touch/features/chat/domain/repo/chat_repo.dart';

class SendMessagesUseCase {
  final ChatRepository repository = ChatRepoImpl();
  Future<dynamic> call({required String receiverId, required String content, required String messageType, String mediaUrl = ""}) async {
    return await repository.sendMessage(receiverId: receiverId, content: content, messageType: messageType, mediaUrl: mediaUrl);
  }
}