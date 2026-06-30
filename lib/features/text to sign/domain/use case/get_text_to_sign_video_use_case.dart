import 'dart:io';

import 'package:en_touch/features/text%20to%20sign/data/model/extract_audio_from_video_model.dart';
import 'package:en_touch/features/text%20to%20sign/data/repo/text_to_sign_repo_impl.dart';
import 'package:en_touch/features/text%20to%20sign/domain/repo/text_to_sign_repo.dart';

class GetTextToSignVideoUseCase {
  final TextToSignRepo textToSignRepo = TextToSignRepoImpl();

  Future<ExtractAudioFromVideoModel> call(File filePath) async {
    return await textToSignRepo.getTextToSignVideo(filePath);
  }
}