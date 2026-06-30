import 'package:en_touch/features/community/data/models/get_post_model.dart';
import 'package:en_touch/features/community/data/repo/community_repo_impl.dart';
import 'package:en_touch/features/community/domain/repo/community_repo.dart';

class GetMyPostsUseCase {
  CommunityRepo communityRepo = CommunityRepoImpl();

  Future<List<GetPostModel>> call() async {
    return await communityRepo.getMyPosts();
}   
}