import 'package:dio/dio.dart';
import 'package:en_touch/core/api/api_manager.dart';
import 'package:en_touch/core/api/end_points.dart';
import 'package:en_touch/features/learn%20new%20sign/data/source/learn_new_sign_data_source.dart';

class LearnNewSignDataSourceImpl extends LearnNewSignDataSource {
  ApiManager apiManager = ApiManager();
  EndPoints endPoints = EndPoints();

  @override
  Future<Response?> saveHistory(String inputText) async {
    return await apiManager.post(endPoint: endPoints.saveHistory, data: {'inputText': inputText});
  }
  
}