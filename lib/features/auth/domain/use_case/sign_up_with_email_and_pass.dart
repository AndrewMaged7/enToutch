import 'package:en_touch/features/auth/data/models/auth_model.dart';
import 'package:en_touch/features/auth/data/repo/auth_repo_impl.dart';
import 'package:en_touch/features/auth/domain/repo/auth_repo.dart';

class SignUpWithEmailAndPass {
  final AuthRepo authRepo = AuthRepoImpl();


  Future<AuthModel> call({required String fullName,required String email, required String password,required bool isDeaf,required bool isMute}) async {
     return await authRepo.signUpWithEmailAndPassword(fullName: fullName, email: email, password: password, isDeaf: isDeaf, isMute: isMute);
  }
}