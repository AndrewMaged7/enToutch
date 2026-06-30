import 'package:dio/dio.dart';

abstract class AuthDataSource {
  Future<Response?> logInWithEmailAndPassword({required String email,required String password});
  Future<Response?> signUpWithEmailAndPassword({required String fullName, required String email, required String password, required bool isDeaf, required bool isMute});
  Future<Response?> logInWithGoogle({required String idToken});
  Future<Response?> logOut({required String refreshToken});
  Future<Response?> forgetPasswordSendEmail({required String email});
  Future<Response?> forgetPasswordSendOtp({required String otp, required String email});
  Future<Response?> forgetPasswordSendNewPass({required String newPass, required String email});
  Future<Response?> sendFcmToken({required String fcmToken});
}