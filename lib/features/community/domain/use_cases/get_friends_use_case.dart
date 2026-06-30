import 'package:en_touch/features/community/data/models/my_friends_model.dart';
import 'package:en_touch/features/community/data/repo/community_repo_impl.dart';
import 'package:en_touch/features/community/domain/repo/community_repo.dart';

class GetFriendsUseCase {
  CommunityRepo communityRepo = CommunityRepoImpl();
  Future<List<GetFriendsModel>> call() async {
      return await communityRepo.getFriends();
  }
}