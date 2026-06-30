import 'package:en_touch/features/auth/data/models/auth_model.dart';
import 'package:en_touch/features/auth/data/models/fcm_model.dart';
import 'package:en_touch/features/auth/data/models/forget_pass_model.dart';
import 'package:en_touch/features/auth/data/models/log_out_model.dart';

abstract class AuthRepo {
  Future<AuthModel> logInWithEmailAndPassword({required String email, required String password});
  Future<AuthModel> signUpWithEmailAndPassword({required String fullName, required String email, required String password, required bool isDeaf, required bool isMute});
  Future<Map<String, dynamic>?> signinWithGoogle();
  Future<ForgetPassModel?> forgetPasswordSendEmail({required String email});
  Future<LogOutModel> signOut({required String refreshToken});
  Future<ForgetPassModel?> forgetPasswordSendOtp({required String otp, required String email});
  Future<ForgetPassModel?> forgetPasswordSendNewPass({required String newPass, required String email});
  Future<FcmModel> sendFcmToken({required String fcmToken});
}