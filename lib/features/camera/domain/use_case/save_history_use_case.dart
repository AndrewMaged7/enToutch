import 'package:en_touch/features/camera/data/model/save_history_model.dart';
import 'package:en_touch/features/camera/domain/repo/camera_repo.dart';

class SaveHistoryUseCase {
  final CameraRepo cameraRepo;

  SaveHistoryUseCase(this.cameraRepo);

  Future<SaveHistoryModel> call(String inputText) async {
    return await cameraRepo.saveHistory(inputText);
  }
}