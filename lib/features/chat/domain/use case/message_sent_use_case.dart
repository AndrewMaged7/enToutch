import 'package:en_touch/features/chat/data/repo/chat_repo_impl.dart';
import 'package:en_touch/features/chat/domain/repo/chat_repo.dart';

class MessageSentUseCase {
  final ChatRepository repository;

  MessageSentUseCase({ChatRepository? repository})
      : repository = repository ?? ChatRepoImpl();

  Future<void> sendMessage({
    required String receiverId,
    required String content,
    required String messageType,
  }) {
    return repository.sendMessage(receiverId: receiverId, content: content, messageType: messageType);
  }
}