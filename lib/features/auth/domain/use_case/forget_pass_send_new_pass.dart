import 'package:en_touch/features/auth/data/models/forget_pass_model.dart';
import 'package:en_touch/features/auth/data/repo/auth_repo_impl.dart';
import 'package:en_touch/features/auth/domain/repo/auth_repo.dart';

class ForgetPassSendNewPass {
  final AuthRepo authRepo = AuthRepoImpl();


  Future<ForgetPassModel?> call({required String email, required String newPassword}) async {
     return await authRepo.forgetPasswordSendNewPass(email: email, newPass: newPassword);
  }
}