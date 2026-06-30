import 'package:en_touch/features/setting/data/model/pending_model.dart';
import 'package:en_touch/features/setting/data/repo/setting_repo_impl.dart';
import 'package:en_touch/features/setting/domain/repo/setting_repo.dart';

class GetPendingUseCase {
  SettingRepo settingRepo = SettingRepoImpl();
  Future<List<PendingModel>> call() async {
    return await settingRepo.getPending();
  }
}