import 'package:dio/dio.dart';

abstract class ResultDataSource {
  Future<Response?> getResult();
}