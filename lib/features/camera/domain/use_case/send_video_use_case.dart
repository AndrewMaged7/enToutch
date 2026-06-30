import 'dart:io';

import 'package:en_touch/features/camera/data/model/sign_to_text_model.dart';
import 'package:en_touch/features/camera/data/repo/camera_repo_impl.dart';
import 'package:en_touch/features/camera/domain/repo/camera_repo.dart';

class SendVideoUseCase {
  final CameraRepo cameraRepo = CameraRepoImpl();


  Future<SignToTextModel> call(File file) async {
    return await cameraRepo.signToText(file);
  }
}