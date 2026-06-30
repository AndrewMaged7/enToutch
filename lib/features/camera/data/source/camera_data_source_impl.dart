import 'dart:io';

import 'package:dio/dio.dart';
import 'package:en_touch/core/api/api_manager.dart';
import 'package:en_touch/core/api/end_points.dart';
import 'package:en_touch/features/camera/data/source/camera_data_source.dart';

class CameraDataSourceImpl implements CameraDataSource {

  ApiManager apiManager = ApiManager();
  EndPoints endPoints = EndPoints();
  
  @override
  Future<Response?> sendAnswer(String text) async {
    return await apiManager.post(endPoint: 'path', data: {'text': text});
  }
  
  @override
  Future<Response<dynamic>?> getResultVideo() async {
    return await apiManager.get(endPoint: 'path');
  }
  

  @override
Future<Response?> signToText(File file) async {
  final formData = FormData.fromMap({
    'video': await MultipartFile.fromFile(
      file.path,
      filename: file.path.split('/').last,
    ),
  });
  return await apiManager.post(
    endPoint: endPoints.signToText,
    data: formData,
    extra: {
      'filePath': file.path,
      'fileKey': 'video',
    },
  );
}

  @override
  Future<Response<dynamic>?> saveHistory(String inputText) async {
    return await apiManager.post(endPoint: endPoints.saveHistory, data: {'inputText': inputText});
    
  }
  
  @override
  Future<Response<dynamic>?> sendResult(String resultText) async {
    return await apiManager.post(endPoint: endPoints.saveHistory, data: {'inputText': resultText});
  }
  
}