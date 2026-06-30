import 'package:en_touch/features/camera/data/repo/camera_repo_impl.dart';
import 'package:en_touch/features/camera/domain/repo/camera_repo.dart';

class GetResultUseCase {
  final CameraRepo cameraRepo = CameraRepoImpl();

  Future<void> call() async {
    return await cameraRepo.getResultVideo();
  }
}