part of 'result_cubit.dart';

@immutable
sealed class ResultState {}

final class ResultInitial extends ResultState {}

final class ResultLoading extends ResultState {}
final class ResultSuccess extends ResultState {}
final class ResultError extends ResultState {
  final String error;
  ResultError(this.error);
}

final class SaveToGallerySuccess extends ResultState {}
final class SaveToGalleryLoading extends ResultState {}
final class SaveToGalleryError extends ResultState {
  final String error;
  SaveToGalleryError(this.error);
}
