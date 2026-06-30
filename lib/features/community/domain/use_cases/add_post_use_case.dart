import 'package:en_touch/features/community/data/models/add_post_model.dart';
import 'package:en_touch/features/community/data/repo/community_repo_impl.dart';
import 'package:en_touch/features/community/domain/repo/community_repo.dart';

class AddPostUseCase {
  CommunityRepo communityRepo = CommunityRepoImpl();

  Future<AddPostModel> call({required String content,String? mediaUrl,String? mediaType}) async {
    return await communityRepo.addPost(content: content, mediaUrl: mediaUrl, mediaType: mediaType);
}
}