import 'package:en_touch/features/camera/data/model/save_history_model.dart';
import 'package:en_touch/features/camera/data/repo/camera_repo_impl.dart';
import 'package:en_touch/features/camera/domain/repo/camera_repo.dart';

class SendResult {
  CameraRepo cameraRepo = CameraRepoImpl();

  Future<SaveHistoryModel> call(String resultText) async {
    return await cameraRepo.sendResult(resultText);
  }
}
