import 'package:en_touch/features/auth/data/models/auth_model.dart';
import 'package:en_touch/features/auth/data/repo/auth_repo_impl.dart';
import 'package:en_touch/features/auth/domain/repo/auth_repo.dart';

class SignInWithEmailAndPass {
  final AuthRepo authRepo = AuthRepoImpl();


  Future<AuthModel> call({required String email, required String password}) async {
     return await authRepo.logInWithEmailAndPassword(email: email, password: password);
  }
}