import 'package:en_touch/features/setting/data/model/get_friends_model.dart';
import 'package:en_touch/features/setting/data/repo/setting_repo_impl.dart';
import 'package:en_touch/features/setting/domain/repo/setting_repo.dart';

class GetFriendsUseCase {
  SettingRepo settingRepo = SettingRepoImpl();
  Future<List<GetFriendsModel>> call() async {
      return await settingRepo.getFriends();
  }
}