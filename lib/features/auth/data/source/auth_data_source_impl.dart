import 'package:dio/dio.dart';
import 'package:en_touch/core/api/api_manager.dart';
import 'package:en_touch/core/api/end_points.dart';
import 'package:en_touch/features/auth/data/source/auth_data_source.dart';

class AuthDataSourceImpl extends AuthDataSource {
  ApiManager apiManager = ApiManager();
  EndPoints endPoints = EndPoints();
  @override
  Future<Response?> logInWithEmailAndPassword({required String email, required String password}) async {
    return await apiManager.post(endPoint: endPoints.login, data: {"email": email, "password": password});
  }
  
  @override
  Future<Response?> signUpWithEmailAndPassword({required String fullName, required String email, required String password, required bool isDeaf, required bool isMute}) async {
    return await apiManager.post(endPoint: endPoints.signUp, data: {"fullName": fullName, "email": email, "password": password, "isDeaf": isDeaf, "isMute": isMute});
  }
  
  @override
  Future<Response<dynamic>?> logOut({required String refreshToken}) async {
    return await apiManager.post(endPoint: endPoints.logout, data: {"refreshToken": refreshToken});
  }
  
  @override
  Future<Response<dynamic>?> logInWithGoogle({required String idToken}) async {
    return await apiManager.post(endPoint: endPoints.signInWithGoogle, data: {"idToken": idToken});
  }
  
  @override
  Future<Response> forgetPasswordSendEmail({required String email}) async {
    return await apiManager.post(endPoint: endPoints.forgetPasswordSendEmail, data: {"email": email});
  }
  
  @override
  Future<Response> forgetPasswordSendNewPass({required String newPass, required String email}) async {
    return await apiManager.post(endPoint: endPoints.forgetPasswordSendNewPass, data: {"newPassword": newPass, "email": email});
  }
  
  @override
  Future<Response> forgetPasswordSendOtp({required String otp, required String email}) async {
    return await apiManager.post(endPoint: endPoints.forgetPasswordSendOtp, data: {"otp": otp, "email": email});
  }
  
  @override
  Future<Response<dynamic>?> sendFcmToken({required String fcmToken}) async {
    return await apiManager.post(endPoint: endPoints.sendFcmToken, data: {"fcmToken": fcmToken});
  }
  
  }
  
