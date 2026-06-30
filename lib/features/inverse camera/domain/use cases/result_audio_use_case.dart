import 'package:en_touch/features/inverse%20camera/data/repo/inverse_camera_repo_impl.dart';
import 'package:en_touch/features/inverse%20camera/domain/repo/inverse_camera_repo.dart';

class InverseCameraResultAudioUseCase {
  InverseCameraRepo inverseCameraRepo = InverseCameraRepoImpl();

  Future<String?> call() async {
    return await inverseCameraRepo.sendResultAudio();
  }
}