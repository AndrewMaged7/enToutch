import 'package:en_touch/features/setting/data/model/search_friend_model.dart';
import 'package:en_touch/features/setting/data/repo/setting_repo_impl.dart';
import 'package:en_touch/features/setting/domain/repo/setting_repo.dart';

class SearchFriendsUseCase {
   final SettingRepo settingRepo = SettingRepoImpl();

   Future<List<SearchFriendsModel>> call(String name) async {
     return await settingRepo.searchFriends(name);
   }
}