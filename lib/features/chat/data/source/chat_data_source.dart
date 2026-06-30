
import 'dart:io';

import 'package:dio/dio.dart';

abstract class ChatDataSource {
  Future<Response> getChatConversations(String userId);
  Future<Response?> sendText(String text);
  Future<Response?> extractAudioFromVideo(File videoPath);
}