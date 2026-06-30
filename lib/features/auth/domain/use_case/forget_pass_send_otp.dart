import 'package:en_touch/features/auth/data/models/forget_pass_model.dart';
import 'package:en_touch/features/auth/data/repo/auth_repo_impl.dart';
import 'package:en_touch/features/auth/domain/repo/auth_repo.dart';

class ForgetPasswordSendOtp {
  final AuthRepo authRepo = AuthRepoImpl();


  Future<ForgetPassModel?> call({required String email, required String otp}) async {
     return await authRepo.forgetPasswordSendOtp(email: email, otp: otp);
  }
}