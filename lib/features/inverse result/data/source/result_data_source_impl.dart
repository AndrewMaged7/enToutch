import 'package:dio/dio.dart';
import 'package:en_touch/core/api/api_manager.dart';
import 'package:en_touch/features/inverse%20result/data/source/result_data_source.dart';

class InverseResultDataSourceImpl implements InverseResultDataSource {
  ApiManager apiManager = ApiManager();
  @override
  Future<Response?> getResult()async {
    return await apiManager.get(endPoint: "path");
  }
}