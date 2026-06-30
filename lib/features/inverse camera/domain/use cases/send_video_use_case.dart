import 'dart:io';

import 'package:en_touch/features/inverse%20camera/data/models/inverse-camera_sign_to_text_model.dart';
import 'package:en_touch/features/inverse%20camera/data/repo/inverse_camera_repo_impl.dart';
import 'package:en_touch/features/inverse%20camera/domain/repo/inverse_camera_repo.dart';

class InverseCameraSendVideoUseCase {
  final InverseCameraRepo inverseCameraRepo = InverseCameraRepoImpl();


  Future<InverseCameraSignToTextModel> call(File file) async {
    return await inverseCameraRepo.signToText(file);
  }
}