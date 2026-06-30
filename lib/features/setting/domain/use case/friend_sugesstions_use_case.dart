import 'package:en_touch/features/setting/data/model/friend_suggestions_model.dart';
import 'package:en_touch/features/setting/data/repo/setting_repo_impl.dart';
import 'package:en_touch/features/setting/domain/repo/setting_repo.dart';

class FriendsSuggestionsUseCase {
  SettingRepo settingRepo = SettingRepoImpl();

  Future<List<FriendSuggestionsModel>> call() async {
    return await settingRepo.getFriendSuggestions();
  }
}