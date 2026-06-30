part of 'history_cubit.dart';

sealed class HistoryState {}

final class HistoryInitial extends HistoryState {}
final class HistoryLoading extends HistoryState {}
final class HistorySuccess extends HistoryState {}
final class HistoryError extends HistoryState {
  final String errorMessage;

  HistoryError(this.errorMessage);
}
