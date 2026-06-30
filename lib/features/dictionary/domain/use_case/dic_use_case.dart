import 'package:en_touch/features/dictionary/data/models/dic_model.dart';
import 'package:en_touch/features/dictionary/data/repo/dic_repo_impl.dart';
// import 'package:en_touch/features/dictionary/domain/repo/dic_repo.dart';

class DicUseCase {
  YoutubeService dicRepo = YoutubeService();

  Future<List<YoutubeVideoModel>> getDictionaryData(String apiKey,String inputText) async {
    return await dicRepo.searchVideos(apiKey, inputText);
  }
}