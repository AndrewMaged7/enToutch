import 'package:dio/src/response.dart';
import 'package:en_touch/core/api/api_manager.dart';
import 'package:en_touch/core/api/end_points.dart';
import 'package:en_touch/features/setting/data/source/setting_data_source.dart';

class SettingDataSourceImpl extends SettingDataSource {
  ApiManager apiManager = ApiManager();
  EndPoints endPoints = EndPoints();
  @override
  Future<Response<dynamic>?> getFriendSuggestions() async {
    return await apiManager.get(endPoint: endPoints.getSuggestions);
  }

  @override
  Future<Response<dynamic>?> getFriends() async {
    return await apiManager.get(endPoint: endPoints.getFriends);
  }

  @override
  Future<Response?> getMyChats() async {
    return await apiManager.get(endPoint: endPoints.getMyChats);
  }

  @override
  Future<Response<dynamic>?> getPosts() async {
    return await apiManager.get(endPoint: "path");
  }
  
  @override
  Future<Response?> sendRequest(String userId) async {
    return await apiManager.post(endPoint: "${endPoints.sendRequest}$userId");
  }
  
  @override
  Future<Response<dynamic>?> getPending() async {
    return await apiManager.get(endPoint: endPoints.getPending);
  }
  
  @override
  Future<Response?> acceptRequest(String userId) async {
    return await apiManager.put(endPoint: "${endPoints.acceptRequest}$userId");
  }
  
  @override
  Future<Response<dynamic>?> rejectRequest(String userId) async {
    return await apiManager.put(endPoint: "${endPoints.rejectRequest}$userId");
  }

  @override
  Future<Response<dynamic>?> deleteFriend(String userId) async {
    return await apiManager.delete(endPoint: "${endPoints.deleteFriend}$userId");
  }
  
  @override
  Future<Response<dynamic>?> searchFriends(String name) async {
    return await apiManager.get(endPoint: endPoints.searchFriends , queryParameters: {"q": name});
    
  }
}