part of 'community_cubit.dart';

sealed class CommunityState {}

final class CommunityInitial extends CommunityState {}


final class PostSuccess extends CommunityState {}
final class PostSLoading extends CommunityState {}
final class PostError extends CommunityState {
  final String message;
  PostError(this.message);
}

final class AddCommentSuccess extends CommunityState {}
final class AddCommentLoading extends CommunityState {}
final class AddCommentError extends CommunityState {
  final String message;
  AddCommentError(this.message);
}

final class GetCommentSuccess extends CommunityState {}
final class GetCommentLoading extends CommunityState {}
final class GetCommentError extends CommunityState {
  final String message;
  GetCommentError(this.message);
}

final class RecordCommentSuccess extends CommunityState {}
final class RecordCommentLoading extends CommunityState {}
final class RecordCommentError extends CommunityState {
  final String message;
  RecordCommentError(this.message);
}


final class SendRequestLoading extends CommunityState {}
final class SendRequestSuccess extends CommunityState {}
final class SendRequestError extends CommunityState {
  final String message;
  SendRequestError(this.message);
}

final class GetFriendsLoading extends CommunityState {}
final class GetFriendsSuccess extends CommunityState {}
final class GetFriendsEmpty extends CommunityState {}
final class GetFriendsError extends CommunityState {
  final String message;
  GetFriendsError(this.message);
}


final class PendingEmpty extends CommunityState {}
final class PendingLoading extends CommunityState {}
final class PendingSuccess extends CommunityState {}
final class PendingError extends CommunityState {
  final String message;
  PendingError(this.message);
}


final class SaveLoading extends CommunityState {}
final class SaveSuccess extends CommunityState {}
final class SaveError extends CommunityState {
  final String message;
  SaveError(this.message);
}






final class DisplaySuccess extends CommunityState {}