import 'package:en_touch/features/community/data/models/delete_model.dart';
import 'package:en_touch/features/community/data/repo/community_repo_impl.dart';
import 'package:en_touch/features/community/domain/repo/community_repo.dart';

class DeletePostUseCase {
  CommunityRepo communityRepo = CommunityRepoImpl();

  Future<DeleteModel> call({required String postId}) async {
    return await communityRepo.deletePost(postId: postId);
}   
}