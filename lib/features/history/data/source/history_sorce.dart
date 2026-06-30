import 'package:dio/dio.dart';

abstract class HistorySource {
  Future<Response?> getHistory();
}