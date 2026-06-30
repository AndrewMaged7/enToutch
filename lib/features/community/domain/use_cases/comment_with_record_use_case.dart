import 'package:en_touch/features/community/data/repo/community_repo_impl.dart';
import 'package:en_touch/features/community/domain/repo/community_repo.dart';

class CommentWithRecordUseCase {
  CommunityRepo communityRepo = CommunityRepoImpl();
  Future<String?> call() async {
    return await communityRepo.commentWithRecord();
  }
}