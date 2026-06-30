import 'package:dio/dio.dart';

abstract class DicDataSource {
  Future<Response> getDictionaryData(String inputText);
}