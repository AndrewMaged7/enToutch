import 'package:en_touch/features/community/data/models/delete_model.dart';
import 'package:en_touch/features/community/data/repo/community_repo_impl.dart';
import 'package:en_touch/features/community/domain/repo/community_repo.dart';

class DeleteCommentUseCase {
  CommunityRepo communityRepo = CommunityRepoImpl();

  Future<DeleteModel> call({required String commentId}) async {
    return await communityRepo.deleteComment(commentId: commentId);
}   
}