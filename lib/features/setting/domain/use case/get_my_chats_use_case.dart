import 'package:en_touch/features/setting/data/model/get_my_chats_model.dart';
import 'package:en_touch/features/setting/data/repo/setting_repo_impl.dart';
import 'package:en_touch/features/setting/domain/repo/setting_repo.dart';

class GetMyChatsUseCase {
    final SettingRepo settingRepo = SettingRepoImpl();
  
  
    Future<List<GetMyChatsModel>> call() async {
      return await settingRepo.getMyChats();
    }
}