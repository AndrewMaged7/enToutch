import 'package:en_touch/features/dictionary/data/repo/dic_repo_impl.dart';
import 'package:en_touch/features/dictionary/domain/repo/dic_repo.dart';

class DicTranslationUseCase {
  final DicRepo repo = YoutubeService();

  Future<String?> call() async {
    return await repo.translation();
  }
}