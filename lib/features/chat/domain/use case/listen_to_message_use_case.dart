import 'package:en_touch/features/chat/data/models/message_class.dart';
import 'package:en_touch/features/chat/data/repo/chat_repo_impl.dart';
import 'package:en_touch/features/chat/domain/repo/chat_repo.dart';

class ListenToMessagesUseCase {
  final ChatRepository repository = ChatRepoImpl();


  void call(Function(MessageModel message) onMessage) {
    repository.receiveMessage(onMessage);
  }
}