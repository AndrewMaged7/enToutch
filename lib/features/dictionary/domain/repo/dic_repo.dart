import 'package:en_touch/features/dictionary/data/models/dic_model.dart';

abstract class DicRepo {
  Future<List<YoutubeVideoModel>> searchVideos(
    String apiKey,
    String query,
  );

  Future<String?> translation();
}