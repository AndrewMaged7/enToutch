import 'dart:io';

import 'package:en_touch/features/text%20to%20sign/data/model/extract_audio_from_video_model.dart';
import 'package:en_touch/features/text%20to%20sign/data/model/text_to_sign_model.dart';
import 'package:en_touch/features/text%20to%20sign/data/source/text_to_sign_data_source.dart';
import 'package:en_touch/features/text%20to%20sign/data/source/text_to_sign_data_source_impl.dart';
import 'package:en_touch/features/text%20to%20sign/domain/repo/text_to_sign_repo.dart';

class TextToSignRepoImpl implements TextToSignRepo {
  TextToSignDataSource textToSignDataSource = TextToSignDataSourceImpl();

  @override
  Future<TextToSignModel> sendText(String text) async {
    try {
      var response = await textToSignDataSource.sendText(text);
      if (response!.statusCode! >= 200 && response.statusCode! <= 299) {
        return TextToSignModel.fromJson(response.data);
      } else {
        throw Exception('Failed to send text ${response.statusCode} ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<ExtractAudioFromVideoModel> getTextToSignVideo(File filePath) async {
    try {
      var response = await textToSignDataSource.getTextToSignVideo(filePath);
      if (response!.statusCode! >= 200 && response.statusCode! <= 299) {
        return ExtractAudioFromVideoModel.fromJson(response.data);
      } else {
        throw Exception('Failed to get text to sign video ${response.statusCode} ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}