import 'package:en_touch/features/chat/data/repo/chat_repo_impl.dart';
import 'package:en_touch/features/chat/domain/repo/chat_repo.dart';

class ReceiverMessageUseCase {
  final ChatRepository repository = ChatRepoImpl();



  void receiverMessage(Function(dynamic) onMessage) async {
    return repository.receiveMessage(onMessage);
}}