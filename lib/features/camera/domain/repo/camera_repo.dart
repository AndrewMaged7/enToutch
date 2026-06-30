import 'dart:io';

import 'package:en_touch/features/camera/data/model/save_history_model.dart';
import 'package:en_touch/features/camera/data/model/sign_to_text_model.dart';
import 'package:video_player/video_player.dart';

abstract class CameraRepo {
  String get videoPath;

  Future<String> translation(String text);
  Future<void> textToAudio(String text);
  Future<String?> sendVideo(String videoPath);
  Future<VideoPlayerController> playVideo(String videoPath);
  Future<void> answerText(String text);
  Future<String?> answerWithRecord();
  Future<void> getResultVideo();
  Future<SignToTextModel> signToText(File file);
  Future<SaveHistoryModel> saveHistory(String inputText);
  Future<SaveHistoryModel> sendResult(String resultText);
  Future<String?> sendResultAudio();
}