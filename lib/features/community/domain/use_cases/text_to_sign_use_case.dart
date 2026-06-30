import 'package:en_touch/features/community/data/models/text_to_sign_model.dart';
import 'package:en_touch/features/community/data/repo/community_repo_impl.dart';
import 'package:en_touch/features/community/domain/repo/community_repo.dart';

class TextToSignUseCase {
  CommunityRepo communityRepo = CommunityRepoImpl();

  Future<TextToSignModel> sendText(String text) async {
    return await communityRepo.sendText(text);
  }
}