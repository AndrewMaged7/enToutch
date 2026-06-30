part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class MessageLoading extends ChatState {}
final class MessageSuccess extends ChatState {}
final class MessageError extends ChatState {
  final String message;
  MessageError(this.message);
}

final class PlayVideoSuccess extends ChatState {}
final class PlayVideoLoading extends ChatState {}
final class PlayVideoError extends ChatState {
  final String message;
  PlayVideoError(this.message);
}
