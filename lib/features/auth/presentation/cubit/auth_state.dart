part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}


final class AuthSignInLoadingState extends AuthState {}
final class AuthSignInSuccessState extends AuthState {}
final class AuthSignInErrorState extends AuthState {
  final String message;
  AuthSignInErrorState(this.message);
}

final class LoginSuccess extends AuthState {}


final class AuthRegisterLoadingState extends AuthState {}
final class AuthRegisterSuccessState extends AuthState {}
final class AuthRegisterErrorState extends AuthState {
  final String message;
  AuthRegisterErrorState(this.message);
}


final class SendEmailSuccess extends AuthState {}
final class SendEmailLoading extends AuthState {}
final class SendEmailError extends AuthState {
  final String message;
  SendEmailError(this.message);
}

final class SendOtpSuccess extends AuthState {}
final class SendOtpLoading extends AuthState {}
final class SendOtpError extends AuthState {
  final String message;
  SendOtpError(this.message);
}


final class SendNewPassSuccess extends AuthState {}
final class SendNewPassLoading extends AuthState {}
final class SendNewPassError extends AuthState {
  final String message;
  SendNewPassError(this.message);
}

final class SignOutSuccess extends AuthState {}


final class ObscureToggledState extends AuthState {}

