part of 'text_to_sign_cubit.dart';

@immutable
sealed class TextToSignState {}

final class TextToSignInitial extends TextToSignState {}

final class TextToSignLoading extends TextToSignState {}

final class TextToSignSuccess extends TextToSignState {}

final class TextToSignError extends TextToSignState {
  final String message;
  TextToSignError(this.message);
}


final class SaveToGallerySuccess extends TextToSignState {}
final class SaveToGalleryLoading extends TextToSignState {}
final class SaveToGalleryError extends TextToSignState {
  final String error;
  SaveToGalleryError(this.error);
}


final class VideoToSignLoading extends TextToSignState {}
final class VideoToSignSuccess extends TextToSignState {}
final class VideoToSignError extends TextToSignState {
  final String error;
  VideoToSignError(this.error);
}