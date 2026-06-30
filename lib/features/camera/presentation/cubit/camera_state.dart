part of 'camera_cubit.dart';

@immutable
sealed class CameraState {}

final class CameraInitial extends CameraState {}


final class ChangeTab extends CameraState {}

final class TranslationLoading extends CameraState {}
final class TranslationSuccess extends CameraState {}
final class TranslationError extends CameraState {
  final String error;
  TranslationError(this.error);
}


final class AudioLoading extends CameraState {}
final class AudioSuccess extends CameraState {}
final class AudioFinished extends CameraState {}

final class AudioError extends CameraState {
  final String error;
  AudioError(this.error);
}


final class SendVideoLoading extends CameraState {}
final class SendVideoSuccess extends CameraState {}

final class SendVideoError extends CameraState {
  final String error;
  SendVideoError(this.error);
}

final class SaveToHistory extends CameraState {}

final class ShowTransAndAudioWidget extends CameraState {}

final class PlayVideoLoading extends CameraState {}
final class PlayVideoSuccess extends CameraState {}

final class PlayVideoError extends CameraState {
  final String error;
  PlayVideoError(this.error);
}


final class ChooseAnswerType extends CameraState {}
final class AnswerTextState extends CameraState {}
final class AnswerRecordState extends CameraState {
  final String text;
  AnswerRecordState(this.text);
}


final class SaveHistorySuccess extends CameraState {}
final class SaveHistoryLoading extends CameraState {}
final class SaveHistoryError extends CameraState {
  final String error;
  SaveHistoryError(this.error);
}


final class SendResultLoading extends CameraState {}
final class SendResultSuccess extends CameraState {}
final class SendResultError extends CameraState {
  final String error;
  SendResultError(this.error);
}
