import 'dart:io';
import 'package:en_touch/core/services/app_services.dart';
import 'package:en_touch/features/inverse%20camera/data/models/inverse-camera_sign_to_text_model.dart';
import 'package:en_touch/features/inverse%20camera/data/models/inverse_camera_save_to_history_model.dart';
import 'package:en_touch/features/inverse%20camera/data/source/inverse_camera_data_source.dart';
import 'package:en_touch/features/inverse%20camera/data/source/inverse_camera_data_source_impl.dart';
import 'package:en_touch/features/inverse%20camera/domain/repo/inverse_camera_repo.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:video_player/video_player.dart';

class InverseCameraRepoImpl implements InverseCameraRepo {
  AppServices appServices = AppServices();
  bool isListening = false;
  final stt.SpeechToText speech = stt.SpeechToText();
  String text = 'Press the mic and start speaking...';
  String videoPath = '';
  double confidence = 1.0;
  InverseCameraDataSource inverseCameraDataSource = InverseCameraDataSourceImpl();



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

//  @override
//  Future<List<dynamic>> sendVideo(String videoPath) async {
//   try {
//     final List<dynamic> pickedFiles = await appServices.chooseVideoFromGallery();
//     return pickedFiles;
//   } catch (e) {
//     throw Exception(e.toString());
//   }
// }

  @override
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
  Future<void> getResponse() async {
    try {
      var response = await inverseCameraDataSource.getResponseText();
      if (response!.statusCode! >= 200 && response.statusCode! <= 299) {
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> answerText(String text) async {
    try {
      var response = await inverseCameraDataSource.sendAnswer(text);
      if (response!.statusCode! >= 200 && response.statusCode! <= 299) {
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> getResultVideo() async {
    try {
      var response = await inverseCameraDataSource.getResultVideo();
      if (response!.statusCode! >= 200 && response.statusCode! <= 299) {
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<String?> answerWithRecord() async {
    String? text = await appServices.answerWithRecord();
    var response = await inverseCameraDataSource.sendAnswer(text ?? "");
    if (response!.statusCode! >= 200 && response.statusCode! <= 299) {
    }
    return text;
  }

  @override
  Future<InverseCameraSignToTextModel> signToText(File file) async {
    try {
      var response = await inverseCameraDataSource.signToText(file);
      if (response!.statusCode! >= 200 && response.statusCode! <= 299) {
        return InverseCameraSignToTextModel.fromJson(response.data);
      } else {
        throw Exception('Failed to convert sign to text ${response.statusCode} ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<InverseCameraSaveHistoryModel> saveHistory(String inputText) async {
    var response = await inverseCameraDataSource.saveHistory(inputText);
    if (response!.statusCode! >= 200 && response.statusCode! <= 299) {
      return InverseCameraSaveHistoryModel.fromJson(response.data);
    } else {
      throw Exception('Failed to save history');
    }
  }
  
  @override
  Future<InverseCameraSaveHistoryModel> sendResult(String resultText) async {
    var response = await inverseCameraDataSource.sendResult(resultText);
    try{
      if (response!.statusCode! >= 200 && response.statusCode! <= 299) {
      return InverseCameraSaveHistoryModel.fromJson(response.data);
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
