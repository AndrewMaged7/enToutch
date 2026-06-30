import 'package:en_touch/features/setting/data/model/accept_and_reject_and_delete_model.dart';
import 'package:en_touch/features/setting/data/repo/setting_repo_impl.dart';
import 'package:en_touch/features/setting/domain/repo/setting_repo.dart';

class RejectUseCase {
  SettingRepo settingRepo = SettingRepoImpl();
  Future<AcceptAndRejectAndDeleteModel> call(String userId) async {
    return await settingRepo.rejectRequest(userId);
  }
}