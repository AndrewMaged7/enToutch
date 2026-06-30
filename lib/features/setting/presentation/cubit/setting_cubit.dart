import 'package:bloc/bloc.dart';
import 'package:en_touch/core/cache/hive_cach_helper.dart';
import 'package:en_touch/features/setting/data/model/friend_suggestions_model.dart';
import 'package:en_touch/features/setting/data/model/get_friends_model.dart';
import 'package:en_touch/features/setting/data/model/get_my_chats_model.dart';
import 'package:en_touch/features/setting/data/model/pending_model.dart';
import 'package:en_touch/features/setting/data/model/search_friend_model.dart';
import 'package:en_touch/features/setting/domain/use%20case/accept_use_case.dart';
import 'package:en_touch/features/setting/domain/use%20case/delete_friend_use_case.dart';
import 'package:en_touch/features/setting/domain/use%20case/friend_request_use_case.dart';
import 'package:en_touch/features/setting/domain/use%20case/friend_sugesstions_use_case.dart';
import 'package:en_touch/features/setting/domain/use%20case/get_friends_use_case.dart';
import 'package:en_touch/features/setting/domain/use%20case/get_my_chats_use_case.dart';
import 'package:en_touch/features/setting/domain/use%20case/get_pending_use_case.dart';
import 'package:en_touch/features/setting/domain/use%20case/reject_use_case.dart';
import 'package:en_touch/features/setting/domain/use%20case/search_friends_use_case.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());
  List<FriendSuggestionsModel> friendSuggestions = [];
  List<PendingModel> requests = [];
  List<GetFriendsModel> friends = [];
  List<GetMyChatsModel> myChats = [];
  List<SearchFriendsModel> searchResults = [];

  FriendsSuggestionsUseCase friendsSuggestionsUseCase = FriendsSuggestionsUseCase();
  FriendRequestUseCase friendRequestUseCase = FriendRequestUseCase();
  GetPendingUseCase getPendingUseCase = GetPendingUseCase();
  AcceptUseCase acceptUseCase = AcceptUseCase();
  GetFriendsUseCase getFriendsUseCase = GetFriendsUseCase();
  RejectUseCase rejectUseCase = RejectUseCase();
  GetMyChatsUseCase getMyChatsUseCase = GetMyChatsUseCase();
  DeleteFriendUseCase deleteFriendUseCase = DeleteFriendUseCase();
  SearchFriendsUseCase searchFriendsUseCase = SearchFriendsUseCase();

  TextEditingController searchController = TextEditingController();

  Future<void> getFriendSuggestions() async {
    emit(FriendSuggestionsLoading());
    try {
      List<FriendSuggestionsModel> response = await friendsSuggestionsUseCase.call();
      friendSuggestions = response;
      emit(FriendSuggestionsSuccess());
    } catch (e) {
      emit(FriendSuggestionsError(e.toString()));
      throw Exception(e.toString());
    }
  }

 Future<void> sendRequest(String userId) async {
    emit(SendRequestLoading());
    try {
      await friendRequestUseCase.call(userId);
      emit(SendRequestSuccess());
    } catch (e) {
      emit(SendRequestError(e.toString()));
      throw Exception(e.toString());
    }
  }

  Future<void> getPending() async {
    emit(PendingLoading());
    try {
      List<PendingModel> response = await getPendingUseCase.call();
      requests = response;
      if(requests.isEmpty){
        emit(PendingEmpty());
        return;
      }
      emit(PendingSuccess());
    } catch (e) {
      emit(PendingError(e.toString()));
      throw Exception(e.toString());
    }
  }

  Future<void> acceptRequest(String userId) async {
    emit(AcceptRequestLoading());
    try {
      await acceptUseCase.call(userId);
      emit(AcceptRequestSuccess());
    } catch (e) {
      emit(AcceptRequestError(e.toString()));
      throw Exception(e.toString());
    }
  }
 

 Future<void> getFriends()  async {
  emit(GetFriendsInitial());
   emit(GetFriendsLoading());
   try {
     List<GetFriendsModel> response = await getFriendsUseCase.call();
     friends = response;
     emit(GetFriendsSuccess());
   } catch (e) {
     emit(GetFriendsError(e.toString()));
   }
 }

 Future<void> changeLanguage( BuildContext context,String language) async {
    try {
      if (language == 'en') {
        await context.setLocale(const Locale('en'));
        HiveCacheHelper.saveData<bool>('isEnglish', true);
        emit(ChangeLanguageSuccess());
      } else if (language == 'ar') {
        await context.setLocale(const Locale('ar'));
        HiveCacheHelper.saveData<bool>('isEnglish', false);
        emit(ChangeLanguageSuccess());
      } else {
        throw Exception('Unsupported language code: $language');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

 Future<void> rejectRequest(String userId) async {
    emit(RejectRequestLoading());
    try {
      await rejectUseCase.call(userId);
      emit(RejectRequestSuccess());
    } catch (e) {
      emit(RejectRequestError(e.toString()));
      throw Exception(e.toString());
    }
  }

  Future<void> deleteFriend(String userId) async {
    emit(DeleteFriendLoading());
    try {
      await deleteFriendUseCase.call(userId);
      emit(DeleteFriendSuccess());
    } catch (e) {
      emit(DeleteFriendError(e.toString()));
      throw Exception(e.toString());
    }
  }


  Future<void> getMyChats() async {
    emit(GetChatsLoading());
    try {
      List<GetMyChatsModel> response = await getMyChatsUseCase.call();
      myChats = response;
      if(myChats.isEmpty){
        emit(GetChatsEmpty());
        return;
      }
      emit(GetChatsSuccess());
    } catch (e) {
      emit(GetChatsError(e.toString()));
      throw Exception(e.toString());
    }
  }

  Future<void> searchFriends(String name) async {
  try {
    List<SearchFriendsModel> response = await searchFriendsUseCase.call(name);
    searchResults = response;
    if (response.isEmpty) {
      // emit(SearchFriendsError("No friends found"));
      emit(SearchFriendEmpty());
      return;
    }
    emit(SearchFriendsSuccess());
  } catch (e) {
    emit(SearchFriendsError(e.toString()));
  }
}



}