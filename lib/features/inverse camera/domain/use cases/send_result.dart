import 'package:en_touch/features/inverse%20camera/data/models/inverse_camera_save_to_history_model.dart';
import 'package:en_touch/features/inverse%20camera/data/repo/inverse_camera_repo_impl.dart';
import 'package:en_touch/features/inverse%20camera/domain/repo/inverse_camera_repo.dart';

class InverseCameraSendResult {
  InverseCameraRepo inverseCameraRepo = InverseCameraRepoImpl();

  Future<InverseCameraSaveHistoryModel> call(String resultText) async {
    return await inverseCameraRepo.sendResult(resultText);
  }
}
