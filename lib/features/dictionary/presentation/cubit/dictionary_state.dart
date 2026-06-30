part of 'dictionary_cubit.dart';

@immutable
sealed class DictionaryState {}

final class DictionaryInitial extends DictionaryState {}
final class DictionaryLoading extends DictionaryState {}
final class DictionarySuccess extends DictionaryState {}
final class DictionaryError extends DictionaryState {
  final String message;
  DictionaryError(this.message);
}

final class PlayVideoInitial extends DictionaryState {}
final class PlayVideoLoading extends DictionaryState {}
final class PlayVideoSuccess extends DictionaryState {}
final class PlayVideoError extends DictionaryState {
  final String message;
  PlayVideoError(this.message);
}


final class RecordInitial extends DictionaryState {}
final class RecordLoading extends DictionaryState {}
final class RecordSuccess extends DictionaryState {}
final class RecordError extends DictionaryState {
  final String message;
  RecordError(this.message);
}
