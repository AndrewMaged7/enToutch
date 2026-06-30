import 'package:en_touch/features/setting/data/model/friend_request_model.dart';
import 'package:en_touch/features/setting/data/repo/setting_repo_impl.dart';
import 'package:en_touch/features/setting/domain/repo/setting_repo.dart';

class FriendRequestUseCase {
  SettingRepo settingRepo = SettingRepoImpl();

  Future<FriendRequestModel> call(String userId) async {
    return await settingRepo.sendRequest(userId);
}
}