import 'package:en_touch/features/text%20to%20sign/data/model/text_to_sign_model.dart';
import 'package:en_touch/features/text%20to%20sign/data/repo/text_to_sign_repo_impl.dart';
import 'package:en_touch/features/text%20to%20sign/domain/repo/text_to_sign_repo.dart';

class TextToSignUseCase {
  TextToSignRepo textToSignRepo = TextToSignRepoImpl();

  Future<TextToSignModel> sendText(String text) async {
    return await textToSignRepo.sendText(text);
  }
}