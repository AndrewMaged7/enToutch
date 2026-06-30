import 'package:bloc/bloc.dart';
import 'package:en_touch/core/cache/hive_cach_helper.dart';
import 'package:en_touch/features/auth/data/models/auth_model.dart';
import 'package:en_touch/features/auth/domain/use_case/forget_pass_send_email.dart';
import 'package:en_touch/features/auth/domain/use_case/forget_pass_send_new_pass.dart';
import 'package:en_touch/features/auth/domain/use_case/forget_pass_send_otp.dart';
import 'package:en_touch/features/auth/domain/use_case/sign_in_with_email_and_pass.dart';
import 'package:en_touch/features/auth/domain/use_case/sign_out_use_case.dart';
import 'package:en_touch/features/auth/domain/use_case/sign_up_with_email_and_pass.dart';
import 'package:en_touch/features/auth/domain/use_case/signin_with_google_use_case.dart';
import 'package:flutter/widgets.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {

  GlobalKey<FormState> signinFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> forgetPassSendEmailFormKey = GlobalKey<FormState>();

   TextEditingController signinEmail = TextEditingController();
   TextEditingController signinPassword = TextEditingController();
   

   TextEditingController signupEmail = TextEditingController();
   TextEditingController signupPassword = TextEditingController();
   TextEditingController signupConfirmPassword = TextEditingController();
   TextEditingController signupFullName = TextEditingController();

   TextEditingController forgetPassSendEmail = TextEditingController();
    TextEditingController newPass = TextEditingController();
   TextEditingController optNum1 = TextEditingController();
   TextEditingController optNum2 = TextEditingController();
   TextEditingController optNum3 = TextEditingController();
   TextEditingController optNum4 = TextEditingController();
   TextEditingController optNum5 = TextEditingController();
   TextEditingController optNum6 = TextEditingController();

   String otp = "";
   String email = "";
   bool deafAndMute = false;
   List<FocusNode> otpFocusNodes = List.generate(6, (_) => FocusNode());
   AuthModel? authModel;
  AuthCubit() : super(AuthInitial());

  bool signinObscure = true;
  bool signupObscure = true;
  bool newPassObscure = true;

  Future<void> signInWithEmailAndPassword({required String email, required String password}) async {
    emit(AuthSignInLoadingState());
    try {
      authModel = await SignInWithEmailAndPass().call(email: email, password: password);
      emit(AuthSignInSuccessState());
    } catch (e) {
      emit(AuthSignInErrorState(e.toString()));
    }
  } 

  Future<void> signUpWithEmailAndPassword({required String fullName,required String email,required String password,required bool isDeaf,required bool isMute}) async {
    emit(AuthRegisterLoadingState());
    try {
      authModel= await SignUpWithEmailAndPass().call(fullName: fullName, email: email, password: password, isDeaf: isDeaf, isMute: isMute);
      await HiveCacheHelper.saveData<bool>('isLoggedIn', true);
      emit(AuthRegisterSuccessState());
    } catch (e) {
      emit(AuthRegisterErrorState(e.toString()));
    }
  }


  Future<void> signInWithGoogle() async {
    emit(AuthSignInLoadingState());
    try {
      await SigninWithGoogleUseCase().call();
      await HiveCacheHelper.saveData<bool>('isLoggedIn', true);
      emit(LoginSuccess());
    } catch (e) {
      emit(AuthSignInErrorState(e.toString()));
    }
  }


  Future<void> forgetPasswordSendEmail({required String email}) async {
    emit(SendEmailLoading());
    try {
      await ForgetPassSendEmail().call(email: email);
      emit(SendEmailSuccess());
    } catch (e) {
      emit(SendEmailError(e.toString()));
    }
  }


  Future<void> forgetPasswordSendOtp({required String email, required String otp}) async {
    emit(SendOtpLoading());
    try {
      await ForgetPasswordSendOtp().call(email: email, otp: otp);
      emit(SendOtpSuccess());
    } catch (e) {
      emit(SendOtpError(e.toString()));
    }
  }


  Future<void> forgetPasswordSendNewPass({required String email, required String newPassword}) async {
    emit(SendNewPassLoading());
    try {
      await ForgetPassSendNewPass().call(email: email, newPassword: newPassword);
      emit(SendNewPassSuccess());
    } catch (e) {
      emit(SendNewPassError(e.toString()));
    }
  }
  

  Future<void> signOut({required String refreshToken}) async {
    emit(AuthSignInLoadingState());
    try {
      await SignOutUseCase().call(refreshToken: refreshToken);
      emit(SignOutSuccess());
    } catch (e) {
      emit(AuthSignInErrorState(e.toString()));
    }
  }
            

  void signinSecure() {
    signinObscure = !signinObscure;
    emit(ObscureToggledState());
  }

  void signupSecurePass() {
    signupObscure = !signupObscure;
    emit(ObscureToggledState());
  }

  void signupConfirmPasswordToggle() {
  newPassObscure = !newPassObscure;
  emit(ObscureToggledState());
}
}


