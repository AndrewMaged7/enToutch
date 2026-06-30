import 'package:en_touch/features/chat/data/models/text_to_sign_chat_model.dart';
import 'package:en_touch/features/chat/data/repo/chat_repo_impl.dart';
import 'package:en_touch/features/chat/domain/repo/chat_repo.dart';

class TextToSignChatUseCase {
  ChatRepository textToSignRepo = ChatRepoImpl();

  Future<TextToSignChatModel> sendText(String text) async {
    return await textToSignRepo.sendText(text);
  }
}