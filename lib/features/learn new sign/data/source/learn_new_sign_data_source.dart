import 'package:dio/dio.dart';

abstract class LearnNewSignDataSource {
  Future<Response?> saveHistory(String inputText);

}