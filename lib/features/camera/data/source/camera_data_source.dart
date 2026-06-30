import 'dart:io';

import 'package:dio/dio.dart';

abstract class CameraDataSource {
  Future<Response?> sendAnswer(String text);
  Future<Response?> getResultVideo();
  Future<Response?> signToText(File file);
  Future<Response?> saveHistory(String inputText);
  Future<Response?> sendResult(String resultText);
}