import 'package:dio/dio.dart';
import 'package:en_touch/core/api/api_manager.dart';
import 'package:en_touch/core/api/end_points.dart';
import 'package:en_touch/features/dictionary/data/sources/dic_datat_source.dart';

class DicDataSourceImpl implements DicDataSource {
  ApiManager apiManager = ApiManager();
  EndPoints endPoints = EndPoints();

  @override
  Future<Response> getDictionaryData(String inputText) async {
    return await apiManager.post(endPoint: endPoints.dictionary, data: {"inputText": inputText});
  }
} 