import 'package:en_touch/features/auth/data/models/fcm_model.dart';
import 'package:en_touch/features/auth/data/repo/auth_repo_impl.dart';
import 'package:en_touch/features/auth/domain/repo/auth_repo.dart';

class FcmTokenUseCase {
  AuthRepo authRepo = AuthRepoImpl();
  Future<FcmModel> sendFcmToken({required String fcmToken}) async {
    return await authRepo.sendFcmToken(fcmToken: fcmToken);
  }
}
