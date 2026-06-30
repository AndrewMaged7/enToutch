import 'dart:io';

import 'package:dio/dio.dart';
import 'package:en_touch/core/api/api_manager.dart';
import 'package:en_touch/core/api/end_points.dart';
import 'package:en_touch/features/text%20to%20sign/data/source/text_to_sign_data_source.dart';

class TextToSignDataSourceImpl implements TextToSignDataSource {
  ApiManager apiManager = ApiManager();
  EndPoints endPoints = EndPoints();
  @override
  Future<Response?> sendText(String text) async {
    return await apiManager.post(endPoint: endPoints.saveHistory, data: {"inputText": text});
  }
  
  @override
  Future<Response<dynamic>?> getTextToSignVideo(File filePath) async {
    FormData formData = FormData.fromMap({
      'videoFile': await MultipartFile.fromFile(filePath.path, filename: filePath.path.split('/').last),
    });
    
    return await apiManager.post(
    endPoint: endPoints.extractAudioFromVideo,
    data: formData,
    extra: {
      'filePath': filePath.path,
      'fileKey': 'videoFile',
    },
  );
    
  }
}