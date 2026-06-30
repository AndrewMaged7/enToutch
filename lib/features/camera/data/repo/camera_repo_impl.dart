import 'dart:async';
import 'dart:io';
import 'package:en_touch/core/services/app_services.dart';
import 'package:en_touch/features/camera/data/model/save_history_model.dart';
import 'package:en_touch/features/camera/data/model/sign_to_text_model.dart';
import 'package:en_touch/features/camera/data/source/camera_data_source.dart';
import 'package:en_touch/features/camera/data/source/camera_data_source_impl.dart';
import 'package:en_touch/features/camera/domain/repo/camera_repo.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:video_player/video_player.dart';

class CameraRepoImpl implements CameraRepo {
  AppServices appServices = AppServices();
  bool isListening = false;
  final stt.SpeechToText speech = stt.SpeechToText();
  String text = 'Press the mic and start speaking...';
  String videoPath = '';
  double confidence = 1.0;
  CameraDataSource cameraDataSource = CameraDataSourceImpl();

  @override
  Future<String> translation(String text) async {
    try {
      return await appServices.translation(text);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> textToAudio(String text) async {
    try {
      await appServices.textToAudio(text);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
//   Future<List<dynamic>> sendVideo(String videoPath) async {
//   try {
//     final List<dynamic> pickedFiles = await appServices.chooseVideoFromGallery();
//     return pickedFiles;
//   } catch (e) {
//     print('Error in sendVideo: $e');
//     throw Exception(e.toString());
//   }
// }
  Future<String?> sendVideo(String videoPath) async {
  try {
    final String? pickedPath = await appServices.chooseVideoFromGallery();
    if (pickedPath == null || pickedPath.isEmpty) return null;
    this.videoPath = pickedPath;
    return pickedPath;
  } catch (e) {
    throw Exception(e.toString());
  }
}

  @override
  Future<VideoPlayerController> playVideo(String videoPath) async {
    try {
      final controller = VideoPlayerController.networkUrl(Uri.parse(videoPath));
      await controller.initialize();
      await controller.play();
      return controller;
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  @override
  Future<void> answerText(String text) async {
    try {
      var response = await cameraDataSource.sendAnswer(text);
      if (response!.statusCode! >= 200 && response.statusCode! <= 299) {
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> getResultVideo() async {
    try {
      var response = await cameraDataSource.getResultVideo();
      if (response!.statusCode! >= 200 && response.statusCode! <= 299) {
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<String?> answerWithRecord() async {
    String? text = await appServices.answerWithRecord();
    var response = await cameraDataSource.sendAnswer(text ?? "");
    if (response!.statusCode! >= 200 && response.statusCode! <= 299) {
    }
    return text;
  }

  @override
  Future<SignToTextModel> signToText(File file) async {
    try {
      var response = await cameraDataSource.signToText(file);
      if (response!.statusCode! >= 200 && response.statusCode! <= 299) {
        return SignToTextModel.fromJson(response.data);
      } else {
        throw Exception('Failed to convert sign to text');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
//   Future<SaveHistoryModel> saveHistory(String inputText) async {
//   var response = await cameraDataSource.saveHistory(inputText);
//   if (response!.statusCode! >= 200 && response.statusCode! <= 299) {
//     // Handle if API wraps result in a list
//     final data = response.data is List 
//         ? (response.data as List).first 
//         : response.data as Map<String, dynamic>;
//     return SaveHistoryModel.fromJson(data);
//   } else {
//     throw Exception('Failed to save history');
//   }
// }
  Future<SaveHistoryModel> saveHistory(String inputText) async {
    var response = await cameraDataSource.saveHistory(inputText);
    if (response!.statusCode! >= 200 && response.statusCode! <= 299) {
      return SaveHistoryModel.fromJson(response.data);
    } else {
      throw Exception('Failed to save history');
    }
  }
  
  @override
//   Future<SaveHistoryModel> sendResult(String resultText) async {
//   var response = await cameraDataSource.sendResult(resultText);
//   try {
//     if (response!.statusCode! >= 200 && response.statusCode! <= 299) {
//       final data = response.data is List 
//           ? (response.data as List).first 
//           : response.data as Map<String, dynamic>;
//       return SaveHistoryModel.fromJson(data);
//     } else {
//       throw Exception('Failed to send result');
//     }
//   } catch (e) {
//     throw Exception('Failed to send result: $e');
//   }
// }
  Future<SaveHistoryModel> sendResult(String resultText) async {
    var response = await cameraDataSource.sendResult(resultText);
    try{
      if (response!.statusCode! >= 200 && response.statusCode! <= 299) {
      return SaveHistoryModel.fromJson(response.data);
    } else {
      throw Exception('Failed to send result');
    }
    } catch (e) {
      throw Exception('Failed to send result');
    }
  }
  
  @override
  Future<String?> sendResultAudio() async {
    String? text = await appServices.answerWithRecord();
    return text;
  }
}
