import 'package:en_touch/features/community/data/models/add_friend_model.dart';
import 'package:en_touch/features/community/data/repo/community_repo_impl.dart';
import 'package:en_touch/features/community/domain/repo/community_repo.dart';

class FriendRequestUseCase {
  CommunityRepo communityRepo = CommunityRepoImpl();

  Future<FriendRequestModel> call(String userId) async {
    return await communityRepo.sendRequest(userId);
}
}