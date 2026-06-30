import 'package:dio/dio.dart';

abstract class SettingDataSource {
  Future<Response?> getFriends();
  Future<Response?> getMyChats();
  Future<Response?> getFriendSuggestions();
  Future<Response?> sendRequest(String userId);
  Future<Response?> getPending();
  Future<Response?> acceptRequest(String userId);
  Future<Response?> rejectRequest(String userId);
  Future<Response?> deleteFriend(String userId);
  Future<Response?> getPosts();
  Future<Response?> searchFriends(String name);
}