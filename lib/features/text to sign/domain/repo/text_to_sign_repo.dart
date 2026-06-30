import 'dart:io';

import 'package:en_touch/features/text%20to%20sign/data/model/extract_audio_from_video_model.dart';
import 'package:en_touch/features/text%20to%20sign/data/model/text_to_sign_model.dart';

abstract class TextToSignRepo {
  Future<TextToSignModel> sendText(String text);
  Future<ExtractAudioFromVideoModel> getTextToSignVideo(File filePath);
}