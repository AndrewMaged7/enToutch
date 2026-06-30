import 'package:en_touch/features/auth/data/models/log_out_model.dart';
import 'package:en_touch/features/auth/data/repo/auth_repo_impl.dart';
import 'package:en_touch/features/auth/domain/repo/auth_repo.dart';

class SignOutUseCase {
  final AuthRepo authRepo = AuthRepoImpl();


  Future<LogOutModel> call({required String refreshToken}) async {
    return await authRepo.signOut(refreshToken: refreshToken);
  }
}