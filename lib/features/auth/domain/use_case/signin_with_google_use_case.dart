import 'package:en_touch/features/auth/data/repo/auth_repo_impl.dart';
import 'package:en_touch/features/auth/domain/repo/auth_repo.dart';

class SigninWithGoogleUseCase {
  final AuthRepo authRepo = AuthRepoImpl();

  Future<Map<String, dynamic>?> call() async {
    return await authRepo.signinWithGoogle();
  }
}