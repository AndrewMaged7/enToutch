part of 'setting_cubit.dart';

// @immutable
sealed class SettingState {}

final class SettingInitial extends SettingState {}

final class FriendSuggestionsLoading extends SettingState {}
final class FriendSuggestionsSuccess extends SettingState {}
final class FriendSuggestionsError extends SettingState {
  final String errorMessage;
  FriendSuggestionsError(this.errorMessage);
}

final class SendRequestLoading extends SettingState {}
final class SendRequestSuccess extends SettingState {}
final class SendRequestError extends SettingState {
  final String errorMessage;
  SendRequestError(this.errorMessage);
}


final class PendingInitial extends SettingState {}
final class PendingLoading extends SettingState {}
final class PendingSuccess extends SettingState {}
final class PendingEmpty extends SettingState {}
final class PendingError extends SettingState {
  final String errorMessage;
  PendingError(this.errorMessage);
}


final class AcceptRequestLoading extends SettingState {}
final class AcceptRequestSuccess extends SettingState {}
final class AcceptRequestError extends SettingState {
  final String errorMessage;
  AcceptRequestError(this.errorMessage);
}

final class RejectRequestLoading extends SettingState {}
final class RejectRequestSuccess extends SettingState {}
final class RejectRequestEmpty extends SettingState {}
final class RejectRequestError extends SettingState {
  final String errorMessage;
  RejectRequestError(this.errorMessage);
}


final class DeleteFriendLoading extends SettingState {}
final class DeleteFriendSuccess extends SettingState {}
final class DeleteFriendError extends SettingState {
  final String errorMessage;
  DeleteFriendError(this.errorMessage);
}


final class GetFriendsInitial extends SettingState {}
final class GetFriendsLoading extends SettingState {}
final class GetFriendsSuccess extends SettingState {}
final class GetFriendsError extends SettingState {
  final String errorMessage;
  GetFriendsError(this.errorMessage);
}

final class ChangeLanguageSuccess extends SettingState {}



final class GetChatsLoading extends SettingState {}
final class GetChatsSuccess extends SettingState {}
final class GetChatsEmpty extends SettingState {}
final class GetChatsError extends SettingState {
  final String errorMessage;
  GetChatsError(this.errorMessage);
}


final class SearchFriendsSuccess extends SettingState {}
final class SearchFriendEmpty extends SettingState {}
final class SearchFriendsLoading extends SettingState {}
final class SearchFriendsError extends SettingState {
  final String errorMessage;
  SearchFriendsError(this.errorMessage);
}