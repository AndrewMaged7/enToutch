part of 'inverse_camera_cubit.dart';

@immutable
sealed class InverseCameraState {}

final class InverseCameraInitial extends InverseCameraState {}


final class ChangeTab extends InverseCameraState {}

final class InverseTranslationLoading extends InverseCameraState {}
final class InverseTranslationSuccess extends InverseCameraState {}
final class InverseTranslationError extends InverseCameraState {
  final String error;
  InverseTranslationError(this.error);
}


final class InverseAudioLoading extends InverseCameraState {}
final class InverseAudioSuccess extends InverseCameraState {}
final class InverseAudioFinished extends InverseCameraState {}

final class InverseAudioError extends InverseCameraState {
  final String error;
  InverseAudioError(this.error);
}


final class InverseSendVideoLoading extends InverseCameraState {}
final class InverseSendVideoSuccess extends InverseCameraState {}

final class InverseSendVideoError extends InverseCameraState {
  final String error;
  InverseSendVideoError(this.error);
}

final class InverseSaveToHistory extends InverseCameraState {}

final class InverseShowTransAndAudioWidget extends InverseCameraState {}

final class InversePlayVideoLoading extends InverseCameraState {}
final class InversePlayVideoSuccess extends InverseCameraState {}

final class InversePlayVideoError extends InverseCameraState {
  final String error;
  InversePlayVideoError(this.error);
}


final class InverseChooseAnswerType extends InverseCameraState {}
final class InverseAnswerTextState extends InverseCameraState {}
final class InverseAnswerRecordState extends InverseCameraState {
  final String text;
  InverseAnswerRecordState(this.text);
}


final class InverseSaveHistorySuccess extends InverseCameraState {}
final class InverseSaveHistoryLoading extends InverseCameraState {}
final class InverseSaveHistoryError extends InverseCameraState {
  final String error;
  InverseSaveHistoryError(this.error);
}


final class InverseSendResultLoading extends InverseCameraState {}
final class InverseSendResultSuccess extends InverseCameraState {}
final class InverseSendResultError extends InverseCameraState {
  final String error;
  InverseSendResultError(this.error);
}