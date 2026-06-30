import 'package:dio/dio.dart';
import 'package:en_touch/core/api/api_manager.dart';
import 'package:en_touch/core/api/end_points.dart';
import 'package:en_touch/features/history/data/source/history_sorce.dart';

class HistorySourceImpl extends HistorySource {
  ApiManager apiManager = ApiManager();
  EndPoints endPoints = EndPoints();
  @override
  Future<Response?> getHistory() async {
    return await apiManager.get(endPoint: endPoints.getHistory);
  }
 
}