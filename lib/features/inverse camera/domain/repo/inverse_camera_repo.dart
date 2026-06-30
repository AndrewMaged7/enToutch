

import 'dart:io';

import 'package:en_touch/features/inverse%20camera/data/models/inverse-camera_sign_to_text_model.dart';
import 'package:en_touch/features/inverse%20camera/data/models/inverse_camera_save_to_history_model.dart';
import 'package:video_player/video_player.dart';

abstract class InverseCameraRepo {
  String get videoPath;

  Future<String> translation(String text);
  Future<void> textToAudio(String text);
  Future<String?> sendVideo(String videoPath);
  Future<VideoPlayerController> playVideo(String videoPath);
  Future<void> getResponse();
  Future<void> answerText(String text);
  Future<String?> answerWithRecord();
  Future<void> getResultVideo();
  Future<InverseCameraSignToTextModel> signToText(File file);
  Future<InverseCameraSaveHistoryModel> saveHistory(String inputText);
  Future<InverseCameraSaveHistoryModel> sendResult(String resultText);
  Future<String?> sendResultAudio();
}