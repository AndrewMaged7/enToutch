import 'package:en_touch/features/chat/data/models/message_class.dart';
import 'package:en_touch/features/chat/data/repo/chat_repo_impl.dart';
import 'package:en_touch/features/chat/domain/repo/chat_repo.dart';

class GetChatConversation {
  final ChatRepository repository = ChatRepoImpl();

  Future<List<MessageModel>> getChatConversation(String userID) async {
    return await repository.getChatConversations(userID);
}
}