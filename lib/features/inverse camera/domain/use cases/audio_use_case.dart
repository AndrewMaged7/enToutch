import 'package:en_touch/features/inverse%20camera/data/repo/inverse_camera_repo_impl.dart';
import 'package:en_touch/features/inverse%20camera/domain/repo/inverse_camera_repo.dart';

class InverseCameraAudioUseCase {
  final InverseCameraRepo inverseCameraRepo = InverseCameraRepoImpl();

  Future<void> call(String text) async {
    return await inverseCameraRepo.textToAudio(text);
  }
}