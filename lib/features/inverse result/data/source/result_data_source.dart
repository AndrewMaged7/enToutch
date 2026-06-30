import 'package:dio/dio.dart';

abstract class InverseResultDataSource {
  Future<Response?> getResult();
}