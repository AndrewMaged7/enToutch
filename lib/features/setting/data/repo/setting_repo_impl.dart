import 'package:en_touch/features/setting/data/model/accept_and_reject_and_delete_model.dart';
import 'package:en_touch/features/setting/data/model/friend_request_model.dart';
import 'package:en_touch/features/setting/data/model/friend_suggestions_model.dart';
import 'package:en_touch/features/setting/data/model/get_friends_model.dart';
import 'package:en_touch/features/setting/data/model/get_my_chats_model.dart';
import 'package:en_touch/features/setting/data/model/pending_model.dart';
import 'package:en_touch/features/setting/data/model/search_friend_model.dart';
import 'package:en_touch/features/setting/data/source/setting_data_source.dart';
import 'package:en_touch/features/setting/data/source/setting_data_source_impl.dart';
import 'package:en_touch/features/setting/domain/repo/setting_repo.dart';

class SettingRepoImpl extends SettingRepo {
  SettingDataSource settingDataSource = SettingDataSourceImpl();
  @override
  Future<List<FriendSuggestionsModel>> getFriendSuggestions() async {
    try {
      var response = await settingDataSource.getFriendSuggestions();
      if(response!.statusCode! >= 200 && response.statusCode! <= 299){
        List<FriendSuggestionsModel> friendSuggestions = (response.data as List).map((e) => FriendSuggestionsModel.fromJson(e)).toList();
        return friendSuggestions;
      }
      throw Exception("Failed to load friend suggestions");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<GetFriendsModel>> getFriends() async {
    try {
      var response = await settingDataSource.getFriends();
      if(response!.statusCode! >= 200 && response.statusCode! <= 299){
        List<GetFriendsModel> friends = (response.data as List).map((e) => GetFriendsModel.fromJson(e)).toList();
        return friends;
      }
      throw Exception("Failed to load friends");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  
  @override
  Future<List<GetMyChatsModel>> getMyChats() async {
    try {
      var response = await settingDataSource.getMyChats();
      if(response!.statusCode! >= 200 && response.statusCode! <= 299){
        List<GetMyChatsModel> myChats = (response.data as List).map((e) => GetMyChatsModel.fromJson(e)).toList();
        return myChats;
      }
      throw Exception("Failed to load my chats");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> getPosts() async {
    try {
      var response = await settingDataSource.getPosts();
      if(response!.statusCode! >= 200 && response.statusCode! <= 299){
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<FriendRequestModel> sendRequest(String userId) async {
    try {
      var response = await settingDataSource.sendRequest(userId);
      if(response!.statusCode! >= 200 && response.statusCode! <= 299){
        return FriendRequestModel.fromJson(response.data);
      }
      throw Exception("Failed to send friend request");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<PendingModel>> getPending() async {
    try {
      var response = await settingDataSource.getPending();
      if(response!.statusCode! >= 200 && response.statusCode! <= 299){
        List<PendingModel> pendingRequests = (response.data as List).map((e) => PendingModel.fromJson(e)).toList();
        return pendingRequests;
      }
      throw Exception("Failed to load pending requests");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<AcceptAndRejectAndDeleteModel> acceptRequest(String userId) async {
    try {
      var response = await settingDataSource.acceptRequest(userId);
      if(response!.statusCode! >= 200 && response.statusCode! <= 299){
        return AcceptAndRejectAndDeleteModel.fromJson(response.data);
      }
      throw Exception("Failed to accept friend request");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  
  @override
  Future<AcceptAndRejectAndDeleteModel> rejectRequest(String userId) async {
    try {
      var response = await settingDataSource.rejectRequest(userId);
      if(response!.statusCode! >= 200 && response.statusCode! <= 299){
        return AcceptAndRejectAndDeleteModel.fromJson(response.data);
      }
      throw Exception("Failed to reject friend request");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<AcceptAndRejectAndDeleteModel> deleteFriend(String userId) async {
    try {
      var response = await settingDataSource.deleteFriend(userId);
      if(response!.statusCode! >= 200 && response.statusCode! <= 299){
        return AcceptAndRejectAndDeleteModel.fromJson(response.data);
      }
      throw Exception("Failed to delete friend");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<SearchFriendsModel>> searchFriends(String name) async {
    try {
      var response = await settingDataSource.searchFriends(name);
      if(response!.statusCode! >= 200 && response.statusCode! <= 299){
        List<SearchFriendsModel> searchResults = (response.data as List).map((e) => SearchFriendsModel.fromJson(e)).toList();
        return searchResults;
      }
      throw Exception("Failed to search friends");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}