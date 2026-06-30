import 'package:en_touch/features/camera/data/repo/camera_repo_impl.dart';
import 'package:en_touch/features/camera/domain/repo/camera_repo.dart';

class AnswerTextUseCase {
  final CameraRepo cameraRepo = CameraRepoImpl();

  Future<void> call(String text) async {
    return await cameraRepo.answerText(text);
  }
}