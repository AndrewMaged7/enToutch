part of 'result_cubit.dart';

@immutable
sealed class InverseResultState {}

final class InverseResultInitial extends InverseResultState {}

final class InverseResultLoading extends InverseResultState {}
final class InverseResultSuccess extends InverseResultState {}
final class InverseResultError extends InverseResultState {
  final String error;
  InverseResultError(this.error);
}

final class InverseResultSaveToGallerySuccess extends InverseResultState {}
final class InverseResultSaveToGalleryLoading extends InverseResultState {}
final class InverseResultSaveToGalleryError extends InverseResultState {
  final String error;
  InverseResultSaveToGalleryError(this.error);
}
