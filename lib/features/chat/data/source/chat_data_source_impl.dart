import 'dart:io';

import 'package:en_touch/core/api/api_manager.dart';
import 'package:en_touch/core/api/end_points.dart';
import 'package:en_touch/features/chat/data/source/chat_data_source.dart';
import 'package:dio/dio.dart';

class ChatDataSourceImpl implements ChatDataSource {
  
  ApiManager apiManager = ApiManager();
  EndPoints endPoints = EndPoints();

  @override
  Future<Response> getChatConversations(String userId) async {
    return await apiManager.get(endPoint:  "${endPoints.getChatConversations}$userId",
    );
  }

  @override
  Future<Response?> sendText(String text) async {
    return await apiManager.post(endPoint: endPoints.saveHistory, data: {"inputText": text});
  }

  @override
  Future<Response<dynamic>?> extractAudioFromVideo(File videoPath) async {
    FormData formData = FormData.fromMap({
      "video": MultipartFile.fromFileSync(videoPath.path, filename: videoPath.path.split('/').last),
    });
    return await apiManager.post(
    endPoint: endPoints.extractAudioFromVideo,
    data: formData,
    extra: {
      'filePath': videoPath.path,
      'fileKey': 'video',
    },
  );
  }
 
}