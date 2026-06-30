import 'package:en_touch/features/community/data/models/add_comment_model.dart';
import 'package:en_touch/features/community/data/repo/community_repo_impl.dart';
import 'package:en_touch/features/community/domain/repo/community_repo.dart';

class AddCommentUseCase {
  CommunityRepo communityRepo = CommunityRepoImpl();

  Future<AddCommentModel> call({required String postId, required String content}) async {
    return await communityRepo.addComment(postId: postId, content: content);
}
}