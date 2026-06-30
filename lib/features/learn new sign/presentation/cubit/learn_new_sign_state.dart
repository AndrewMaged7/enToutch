part of 'learn_new_sign_cubit.dart';

@immutable
sealed class LearnNewSignState {}



final class LearnNewSignInitial extends LearnNewSignState {}

final class LearnNewSignSuccess extends LearnNewSignState {}
final class LearnNewSignLoading extends LearnNewSignState {}

final class LearnNewSignError extends LearnNewSignState {
  final String error;
  LearnNewSignError(this.error);
}


final class SaveHistoryLoading extends LearnNewSignState {}
final class SaveHistorySuccess extends LearnNewSignState {}
final class SaveHistoryError extends LearnNewSignState {
  final String error;
  SaveHistoryError(this.error);
}


