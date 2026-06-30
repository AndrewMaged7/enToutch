import 'package:en_touch/features/camera/data/repo/camera_repo_impl.dart';
import 'package:en_touch/features/camera/domain/repo/camera_repo.dart';

class TranslationUseCase {
  final CameraRepo repo = CameraRepoImpl();

  Future<String> call(String text) async {
    return await repo.translation(text);
  }
}