import 'package:en_touch/features/camera/data/repo/camera_repo_impl.dart';
import 'package:en_touch/features/camera/domain/repo/camera_repo.dart';

class ResultAudioUseCase {
  CameraRepo cameraRepo = CameraRepoImpl();

  Future<String?> call() async {
    return await cameraRepo.sendResultAudio();
  }
}