import 'package:dio/dio.dart';
import 'package:en_touch/core/api/api_manager.dart';
import 'package:en_touch/features/result/data/source/result_data_source.dart';

class ResultDataSourceImpl implements ResultDataSource {
  ApiManager apiManager = ApiManager();
  @override
  Future<Response?> getResult()async {
    return await apiManager.get(endPoint: "path");
  }
}