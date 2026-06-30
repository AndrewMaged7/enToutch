import 'package:en_touch/features/community/data/models/add_like_model.dart';
import 'package:en_touch/features/community/data/repo/community_repo_impl.dart';
import 'package:en_touch/features/community/domain/repo/community_repo.dart';

class AddLikeUseCase {
  CommunityRepo communityRepo = CommunityRepoImpl();

  Future<AddLikeModel> call({required String postId}) async {
    return await communityRepo.addLike(postId: postId);
}
}