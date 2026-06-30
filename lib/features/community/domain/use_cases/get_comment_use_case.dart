import 'package:en_touch/features/community/data/models/get_comment_model.dart';
import 'package:en_touch/features/community/data/repo/community_repo_impl.dart';
import 'package:en_touch/features/community/domain/repo/community_repo.dart';

class GetCommentUseCase {
  CommunityRepo communityRepo = CommunityRepoImpl();

  Future<List<GetCommentModel>> call({required String postId}) async {
    return await communityRepo.getComments(postId: postId);
}   
}