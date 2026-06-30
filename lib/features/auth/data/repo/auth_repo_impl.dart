import 'package:dio/dio.dart';
import 'package:en_touch/core/cache/hive_cach_helper.dart';
import 'package:en_touch/features/auth/data/models/auth_model.dart';
import 'package:en_touch/features/auth/data/models/fcm_model.dart';
import 'package:en_touch/features/auth/data/models/forget_pass_model.dart';
import 'package:en_touch/features/auth/data/models/log_out_model.dart';
import 'package:en_touch/features/auth/data/source/auth_data_source.dart';
import 'package:en_touch/features/auth/data/source/auth_data_source_impl.dart';
import 'package:en_touch/features/auth/domain/repo/auth_repo.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepoImpl implements AuthRepo {
  AuthDataSource authDataSource = AuthDataSourceImpl();

  final GoogleSignIn googleSignIn = GoogleSignIn(
    serverClientId:
        '130357473499-2v8k3ej00e5fro79d8t4acg71rj63apj.apps.googleusercontent.com',
    scopes: ['email', 'profile'],
  );

  List<AuthModel> allUsers = [];

  @override
  Future<Map<String, dynamic>?> signinWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account == null) return null;
      final GoogleSignInAuthentication auth = await account.authentication;
      final response = await authDataSource.logInWithGoogle(
        idToken: auth.idToken!,
      );
      if (response != null &&
          response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        AuthModel loginModel = AuthModel.fromJson(response.data);
        await HiveCacheHelper.saveData<AuthModel>('authData', loginModel);
        await HiveCacheHelper.saveData<bool>('logged', true);
      }

      return {
        'idToken': auth.idToken,
        'email': account.email,
        'displayName': account.displayName,
        'photoUrl': account.photoUrl,
      };
    } on DioException catch (e) {
      final message = e.response?.data?['message'] ?? e.message ?? 'Google Sign In failed';
      throw Exception(message);
    } catch (e) {
      throw Exception('Google Sign In Error: ${e.toString()}');
    }
  }

  @override
  Future<AuthModel> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await authDataSource.logInWithEmailAndPassword(
        email: email,
        password: password,
      );
      AuthModel loginModel = AuthModel.fromJson(response!.data);
      final cachedUsers = HiveCacheHelper.getListData<AuthModel>('allUsers');
       HiveCacheHelper.getData<AuthModel>('authData');
      final existingIndex = cachedUsers.indexWhere(
        (user) => (user.id != null && user.id == loginModel.id) ||
            (user.email != null && user.email == loginModel.email),
      );
      if (existingIndex >= 0) {
        cachedUsers[existingIndex] = loginModel;
      } else {
        cachedUsers.add(loginModel);
      }
      allUsers = cachedUsers;
      await HiveCacheHelper.saveData<List<AuthModel>>('allUsers', allUsers);
      await HiveCacheHelper.saveData<AuthModel>('authData', loginModel);
      await HiveCacheHelper.saveData<bool>('logged', true);
      await sendFcmToken(fcmToken: HiveCacheHelper.getData("messageToken")!);
      return loginModel;
    } on DioException catch (e) {
      final message = e.response?.data?['message'] ?? e.message ?? 'Login failed';
      throw Exception(message);
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Failed to sign in: ${e.toString()}');
    }
  }

  @override
  Future<AuthModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
    required bool isDeaf,
    required bool isMute,
  }) async {
    try {
      final response = await authDataSource.signUpWithEmailAndPassword(
        email: email,
        password: password,
        fullName: fullName,
        isDeaf: isDeaf,
        isMute: isMute,
      );
      AuthModel dataModel = AuthModel.fromJson(response!.data);
      await HiveCacheHelper.saveData<AuthModel>('authData', dataModel);
      await HiveCacheHelper.saveData<bool>('logged', true);
      await sendFcmToken(fcmToken: HiveCacheHelper.getData("messageToken")!);
      return dataModel;
    } on DioException catch (e) {
      final message = e.response?.data?['message'] ??
          e.response?.statusMessage ?? e.message ??'Sign up failed';
      throw Exception(message);
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Failed to sign up: ${e.toString()}');
    }
  }
  @override
  Future<LogOutModel> signOut({required String refreshToken}) async {
    try {
      final response = await authDataSource.logOut(refreshToken: refreshToken);
      LogOutModel logOutModel = LogOutModel.fromJson(response!.data);
      await googleSignIn.signOut();
      await FacebookAuth.instance.logOut();
      await HiveCacheHelper.saveData<bool>('logged', false);
      return logOutModel;
    } on DioException catch (e) {
      final message = e.response?.data?['message'] ??
          e.response?.statusMessage ??
          e.message ??
          'Sign out failed';
      throw Exception(message);
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Failed to sign out: ${e.toString()}');
    }
  }

  @override
  Future<ForgetPassModel?> forgetPasswordSendEmail({
    required String email,
  }) async {
    try {
      final response = await authDataSource.forgetPasswordSendEmail(
        email: email,
      );
      return ForgetPassModel.fromJson(response!.data);
    } on DioException catch (e) {
      final message = e.response?.data?['message'] ??
          e.response?.statusMessage ??
          e.message ??
          'Failed to send email';
      throw Exception(message);
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Failed to send forget password email: ${e.toString()}');
    }
  }

  @override
  Future<ForgetPassModel?> forgetPasswordSendNewPass({
    required String newPass,
    required String email,
  }) async {
    try {
      final response = await authDataSource.forgetPasswordSendNewPass(
        email: email,
        newPass: newPass,
      );
      return ForgetPassModel.fromJson(response!.data);
    } on DioException catch (e) {
      final message = e.response?.data?['message'] ??
          e.response?.statusMessage ??
          e.message ??
          'Failed to update password';
      throw Exception(message);
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Failed to send new password: ${e.toString()}');
    }
  }

  @override
  Future<ForgetPassModel?> forgetPasswordSendOtp({
    required String otp,
    required String email,
  }) async {
    try {
      final response = await authDataSource.forgetPasswordSendOtp(
        email: email,
        otp: otp,
      );
      return ForgetPassModel.fromJson(response!.data);
    } on DioException catch (e) {
      final message = e.response?.data?['message'] ??
          e.response?.statusMessage ??
          e.message ??
          'Failed to verify OTP';
      throw Exception(message);
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Failed to send OTP: ${e.toString()}');
    }
  }

  @override
  Future<FcmModel> sendFcmToken({required String fcmToken}) async {
    try{
      var response = await authDataSource.sendFcmToken(fcmToken: fcmToken); 
      if(response!.statusCode! >= 200 && response.statusCode! < 300){
        FcmModel fcmModel = FcmModel.fromJson(response.data);
        return fcmModel;
      } else {
        throw response.statusMessage!;
      }
    }catch(e){
      throw Exception('Failed to send FCM token: ${e.toString()}');
  }
  }
}





















// // import 'package:en_touch/core/cache/hive_cach_helper.dart';
// // import 'package:en_touch/core/cache/cache_helper.dart';
// import 'package:en_touch/core/cache/hive_cach_helper.dart';
// // import 'package:en_touch/core/firebase/firebase_services.dart';
// import 'package:en_touch/features/auth/data/models/auth_model.dart';
// import 'package:en_touch/features/auth/data/models/forget_pass_model.dart';
// import 'package:en_touch/features/auth/data/models/log_out_model.dart';
// import 'package:en_touch/features/auth/data/source/auth_data_source.dart';
// import 'package:en_touch/features/auth/data/source/auth_data_source_impl.dart';
// import 'package:en_touch/features/auth/domain/repo/auth_repo.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthRepoImpl implements AuthRepo {
//   // FirebaseServices firebaseServices = FirebaseServices();

//   AuthDataSource authDataSource = AuthDataSourceImpl();

//   final GoogleSignIn googleSignIn = GoogleSignIn(
//     serverClientId:
//         '130357473499-2v8k3ej00e5fro79d8t4acg71rj63apj.apps.googleusercontent.com',
//     scopes: ['email', 'profile'],
//   );

//   // final FirebaseAuth _auth = FirebaseAuth.instance;

//   List<AuthModel> allUsers = [];
//   // String firebaseToken = "";

//   // final FacebookAuth _facebookSignIn = FacebookAuth.instance;

//   @override
//   Future<Map<String, dynamic>?> signinWithGoogle() async {
//     try {
//       final GoogleSignInAccount? account = await googleSignIn.signIn();
//       if (account == null) return null;
//       final GoogleSignInAuthentication auth = await account.authentication;

//       // البيانات كلها
//       // final String? idToken = auth.idToken;
//       // final String? email = account.email;
//       // final String? displayName = account.displayName;
//       // final String? photoUrl = account.photoUrl;

//       print(auth.idToken);
//       print(account.email);
//       print(account.displayName);

//       print(account.photoUrl);

//       var response = await authDataSource.logInWithGoogle(
//         idToken: auth.idToken!,
//       );
//       if (response!.statusCode! >= 200 && response.statusCode! < 300) {
//         AuthModel loginModel = AuthModel.fromJson(response.data);
//         await HiveCacheHelper.saveData<AuthModel>('authData', loginModel);
//         await HiveCacheHelper.saveData<bool>('logged', true);
//       } else {
//         print(" =============================error---------------------------");
//         print(response.statusCode);
//         print(response.data);
//         throw response.statusMessage!;
//       }

//       return {
//         'idToken': auth.idToken,
//         'email': account.email,
//         'displayName': account.displayName,
//         'photoUrl': account.photoUrl,
//       };
//     } catch (e) {
//       print('Google Sign In Error: $e');
//       return null;
//     }
//   }

//   @override
//   Future<AuthModel> logInWithEmailAndPassword({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       var response = await authDataSource.logInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       if (response!.statusCode! >= 200 && response.statusCode! < 300) {
//         AuthModel loginModel = AuthModel.fromJson(response.data);
//         print("==========================user data");
//         print(loginModel.refreshToken);
//         print("==========================user data");
//         // AuthModel loginModel = AuthModel.fromJson(response.data);
//         // allUsers.add(loginModel);

//         // final users = allUsers.map((user) => allUsers).toList();
//         final cachedUsers = HiveCacheHelper.getListData<AuthModel>('allUsers');

//         final existingUserIndex = cachedUsers.indexWhere(
//           (user) =>
//               (user.id != null && user.id == loginModel.id) ||
//               (user.email != null && user.email == loginModel.email),
//         );

//         if (existingUserIndex >= 0) {
//           cachedUsers[existingUserIndex] = loginModel;
//         } else {
//           cachedUsers.add(loginModel);
//         }

//         allUsers = cachedUsers;
//         await HiveCacheHelper.saveData<List<AuthModel>>('allUsers', allUsers);
//         // await HiveCacheHelper.init('authData');
//         await HiveCacheHelper.saveData<AuthModel>('authData', loginModel);
//         await HiveCacheHelper.saveData<bool>('logged', true);
//         print("==========================user id");
//         print(loginModel.id);
//         print(loginModel.token);
//         return loginModel;
//       } else {
//         print("=============================error---------------------------");
//         print(response.statusMessage);
//         print(response.data);
//         print(response.statusCode);
//         print("=============================error---------------------------");
//         throw response.statusMessage!;
//       }
//     } catch (e) {
//       print(e.toString());
//       if (e is Exception) {
//         rethrow;
//       }
//       throw Exception('Failed to sign in: ${e.toString()}');
//     }
//   }

//   @override
//   Future<AuthModel> signUpWithEmailAndPassword({
//     required String email,
//     required String password,
//     required String fullName,
//     required bool isDeaf,
//     required bool isMute,
//   }) async {
//     try {
//       var response = await authDataSource.signUpWithEmailAndPassword(
//         email: email,
//         password: password,
//         fullName: fullName,
//         isDeaf: isDeaf,
//         isMute: isMute,
//       );
//       if (response!.statusCode! >= 200 && response.statusCode! < 300) {
//         AuthModel dataModel = AuthModel.fromJson(response.data);
//         await HiveCacheHelper.saveData<AuthModel>('authData', dataModel);
//         await HiveCacheHelper.saveData<bool>('logged', true);
//         // save token
//         return dataModel;
//       } else {
//         print(" =============================error---------------------------");
//         print(response.statusCode);
//         throw response.statusMessage!;
//       }
//     } catch (e) {
//       print(e.toString());
//       if (e is Exception) {
//         rethrow;
//       }
//       throw Exception('Failed to sign up: ${e.toString()}');
//     }
//     // on FirebaseAuthException catch (e) {
//     //   throw Exception('Failed to sign up: ${e.message}');
//     // }
//   }

//   @override
//   Future<LogOutModel> signOut({required String refreshToken}) async {
//     var response = await authDataSource.logOut(refreshToken: refreshToken);
//     if (response!.statusCode! >= 200 && response.statusCode! < 300) {
//       // await _auth.signOut();
//       await googleSignIn.signOut();
//       await FacebookAuth.instance.logOut();
//       LogOutModel logOutModel = LogOutModel.fromJson(response.data);
//       // await HiveCacheHelper.saveData<AuthModel>('authData', AuthModel());
//       await HiveCacheHelper.saveData<bool>('logged', false);
//       print(response.data);
//       return logOutModel;
//     } else {
//       print(" =============================error---------------------------");
//       print(response.statusCode);
//       print(response.data);
//       throw response.statusMessage!;
//     }
//   }

//   @override
//   Future<ForgetPassModel?> forgetPasswordSendEmail({
//     required String email,
//   }) async {
//     try {
//       var response = await authDataSource.forgetPasswordSendEmail(email: email);
//       if (response!.statusCode! >= 200 && response.statusCode! < 300) {
//         return ForgetPassModel.fromJson(response.data);
//       } else {
//         print(" =============================error---------------------------");
//         print(response.statusCode);
//         throw response.statusMessage!;
//       }
//     } catch (e) {
//       print(e.toString());
//       if (e is Exception) {
//         rethrow;
//       }
//       throw Exception('Failed to send forget password email: ${e.toString()}');
//     }
//   }

//   @override
//   Future<ForgetPassModel?> forgetPasswordSendNewPass({
//     required String newPass,
//     required String email,
//   }) async {
//     try {
//       var response = await authDataSource.forgetPasswordSendNewPass(email: email, newPass: newPass);
//       if (response!.statusCode! >= 200 && response.statusCode! < 300) {
//         return ForgetPassModel.fromJson(response.data);
//       } else {
//         print(" =============================error---------------------------");
//         print(response.statusCode);
//         throw response.statusMessage!;
//       }
//     } catch (e) {
//       print(e.toString());
//       if (e is Exception) {
//         rethrow;
//       }
//       throw Exception('Failed to send forget password email: ${e.toString()}');
//     }
//   }

//   @override
//   Future<ForgetPassModel?> forgetPasswordSendOtp({
//     required String otp,
//     required String email,
//   }) async {
//     try {
//       var response = await authDataSource.forgetPasswordSendOtp(email: email, otp: otp);
//       if (response!.statusCode! >= 200 && response.statusCode! < 300) {
//         return ForgetPassModel.fromJson(response.data);
//       } else {
//         print(" =============================error---------------------------");
//         print(response.statusCode);
//         throw response.statusMessage!;
//       }
//     } catch (e) {
//       print(e.toString());
//       if (e is Exception) {
//         rethrow;
//       }
//       throw Exception('Failed to send forget password email: ${e.toString()}');
//     }
//   }
// }



























// import 'package:en_touch/features/auth/domain/repo/auth_repo.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthRepoImpl implements AuthRepo {  

//   final FirebaseAuth _auth = FirebaseAuth.instance;


//   @override  
//   Future<UserCredential> signinWithGoogle() async {
//     // Trigger the authentication flow
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//   // Obtain the auth details from the request
//   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

//   // Create a new credential
//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth?.accessToken,
//     idToken: googleAuth?.idToken,
//   );

//   // Once signed in, return the UserCredential
//   return await FirebaseAuth.instance.signInWithCredential(credential); 
//   }  
// }