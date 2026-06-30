import 'dart:io';

import 'package:dio/dio.dart';

abstract class TextToSignDataSource {
  Future<Response?> sendText(String text);
  Future<Response?> getTextToSignVideo(File filePath);
}