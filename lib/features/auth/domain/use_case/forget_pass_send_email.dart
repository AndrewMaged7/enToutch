import 'package:en_touch/features/auth/data/models/forget_pass_model.dart';
import 'package:en_touch/features/auth/data/repo/auth_repo_impl.dart';
import 'package:en_touch/features/auth/domain/repo/auth_repo.dart';

class ForgetPassSendEmail {
  final AuthRepo authRepo = AuthRepoImpl();


  Future<ForgetPassModel?> call({required String email}) async {
     return await authRepo.forgetPasswordSendEmail(email: email);
  }
}