import 'package:en_touch/features/setting/data/model/accept_and_reject_and_delete_model.dart';
import 'package:en_touch/features/setting/data/model/friend_request_model.dart';
import 'package:en_touch/features/setting/data/model/friend_suggestions_model.dart';
import 'package:en_touch/features/setting/data/model/get_friends_model.dart';
import 'package:en_touch/features/setting/data/model/get_my_chats_model.dart';
import 'package:en_touch/features/setting/data/model/pending_model.dart';
import 'package:en_touch/features/setting/data/model/search_friend_model.dart';

abstract class SettingRepo {
  Future<List<GetFriendsModel>> getFriends();
  Future<List<GetMyChatsModel>> getMyChats();
  Future<List<FriendSuggestionsModel>> getFriendSuggestions();
  Future<FriendRequestModel> sendRequest(String userId);
  Future<List<PendingModel>> getPending();
  Future<AcceptAndRejectAndDeleteModel> acceptRequest(String userId);
  Future<AcceptAndRejectAndDeleteModel> rejectRequest(String userId);
  Future<AcceptAndRejectAndDeleteModel> deleteFriend(String userId);
  Future<void> getPosts();
  Future<List<SearchFriendsModel>> searchFriends(String name);
}