
import 'package:en_touch/features/community/data/models/pending_model.dart';
import 'package:en_touch/features/community/data/repo/community_repo_impl.dart';
import 'package:en_touch/features/community/domain/repo/community_repo.dart';

class GetPendingUseCase {
  CommunityRepo communityRepo = CommunityRepoImpl();
  Future<List<PendingModel>> call() async {
    return await communityRepo.getPending();
  }
}