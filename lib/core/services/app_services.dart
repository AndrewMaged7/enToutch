import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:en_touch/core/cache/hive_cach_helper.dart';
import 'package:en_touch/features/auth/data/models/auth_model.dart';
import 'package:en_touch/features/auth/data/repo/auth_repo_impl.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:translator/translator.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class AppServices {
  ImagePicker imagePicker = ImagePicker();
  final FlutterTts flutterTts = FlutterTts();
  GoogleTranslator translator = GoogleTranslator();
  final stt.SpeechToText speech = stt.SpeechToText();
  bool isListening = false;
  final AuthModel? userModel = HiveCacheHelper.getData<AuthModel>("authData");





//    Future<List<File>> chooseVideoFromGallery() async {
//   try {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.video,
//       allowMultiple: true,
//     );
//     if (result != null && result.files.isNotEmpty) {
//       return result.files
//           .where((f) => f.path != null)
//           .map((f) => File(f.path!))
//           .toList();
//     }
//     return [];
//   } catch (e) {
//     throw Exception('Error picking multiple videos: $e');
//   }
// }


// Future<List<dynamic>> chooseVideoFromGallery() async {
//   try {
//     final List<XFile> videos = await imagePicker.pickMultipleMedia(
//       imageQuality: 80,
//     );
//     return videos.where((v) => v.path.isNotEmpty).map((v) => File(v.path)).toList();
//   } on PlatformException catch (e) {
//     if (e.code == 'photo_access_denied' || e.code == 'camera_access_denied') {
//       throw Exception('Camera permission denied. Please enable camera access in settings.');
//     }
//     throw Exception('Unable to access camera: ${e.message ?? e.code}');
//   } catch (e) {
//     throw Exception('Error in chooseVideoFromGallery: $e');
//   }
// }

  Future<String?> chooseVideoFromGallery() async {
    try {
      final XFile? video = await imagePicker.pickVideo(
        source: ImageSource.gallery,
      );
      if (video != null) {
        return video.path;
      }
      return null;
    } on PlatformException catch (e) {
      if (e.code == 'photo_access_denied' || e.code == 'camera_access_denied') {
        throw Exception(
          'Camera permission denied. Please enable camera access in settings.',
        );
      }
      throw Exception('Unable to access camera: ${e.message ?? e.code}');
    } catch (e) {
      throw Exception('Error in startVideo: $e');
    }
  }



// Future<List<File>> chooseVideoFromGalleryAsFile() async {
//   try {
//     final List<XFile> videos = await imagePicker.pickMultipleMedia();
//     if (videos.isNotEmpty) {
//       return videos.map((v) => File(v.path)).toList();
//     }
//     return [];
//   } catch (e) {
//     throw Exception('Error in chooseVideoFromGalleryAsFile: $e');
//   }
// }
  Future<File?> chooseVideoFromGalleryAsFile() async {
    try {
      final XFile? video = await imagePicker.pickVideo(
        source: ImageSource.gallery,
      );
      if (video != null) {
        return File(video.path);
      }
      return null;
    } catch (e) {
      throw Exception('Error in chooseVideoFromGalleryAsFile: $e');
    }
  }


Future<File?> startVideoFromCameraAsFile() async {
    try {
      final hasPermission = await Permission.camera.request();
      if (!hasPermission.isGranted) {
        openAppSettings();
        return null;
      }
      final XFile? video = await imagePicker.pickVideo(
        source: ImageSource.camera,
      );
      if (video != null) {
        return File(video.path);
      }
      return null;
    } catch (e) {
      throw Exception('Error in startVideoFromCameraAsFile: $e');
    }
  }

  Future<String?> startVideoFromCamera() async {
    try {
      final hasPermission = await Permission.camera.request();
      if (!hasPermission.isGranted) {
        openAppSettings();
        return null;
      }
      print("Starting video picker...");
      final XFile? video = await imagePicker.pickVideo(
        source: ImageSource.camera,
      );
      if (video != null) {
        return video.path;
      }
      return null;
    } on PlatformException catch (e) {
      if (e.code == 'photo_access_denied' || e.code == 'camera_access_denied') {
        throw Exception(
          'Camera permission denied. Please enable camera access in settings.',
        );
      }
      throw Exception('Unable to record video: ${e.message ?? e.code}');
    } catch (e) {
      throw Exception('Error in startVideo: $e');
    }
  }

  Future<String?> chooseImage() async {
    XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80, 
    );
    if (image != null) {
      return image.path;
    }
    throw Exception('Failed to pick image');
  }

  Future<void> textToAudio(String text) async {
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }

  Future<String> translation(String text) async {
    Translation translation = await translator.translate(text, to: 'ar');
    return translation.text;
  }

  Future<String?> answerWithRecord() async {
    if (!isListening) {
      bool available = await speech.initialize(
        onStatus: (status) => print('onStatus: $status'),
        onError: (errorNotification) => print('onError: $errorNotification'),
      );
      if (available) {
        isListening = true;
        final completer = Completer<String?>();
        speech.listen(
          onResult: (result) {
            if (result.finalResult) {
              speech.stop();
              isListening = false;
              completer.complete(result.recognizedWords);
            }
          },
        );
        final String? recognizedText = await completer.future;
        Translation translation = await translator.translate(
          recognizedText!,
          to: 'en',
        );
        return translation.text;
      } else {
        return null;
      }
    } else {
      speech.stop();
      isListening = false;
      return null;
    }
  }






  Future<String> uploadToServer(String path) async {
  FormData _buildFormData() => FormData.fromMap({
    'file': MultipartFile.fromFileSync(path),
  });
  final userModel = HiveCacheHelper.getData<AuthModel>("authData");
  final dio = Dio();
  dio.options.headers['Authorization'] = 'Bearer ${userModel?.token ?? ""}';
  try {
    var response = await dio.post(
      'https://entouch.runasp.net/api/Media/upload',
      data: _buildFormData(), // ← instance جديدة
    );
    if (response.data == null) {
      throw Exception("Server returned empty response");
    }
    final fullUrl = "https://entouch.runasp.net" + response.data['url'];
    return fullUrl;
  } on DioException catch (e) {
    if (e.response?.statusCode == 401) {
      bool refreshSuccess = await refreshToken();
      if (!refreshSuccess) {
        throw Exception("Session expired. Please login again.");
      }
      final updatedUser = HiveCacheHelper.getData<AuthModel>("authData");
      dio.options.headers['Authorization'] = 'Bearer ${updatedUser?.token ?? ""}';
      var retryResponse = await dio.post(
        'https://entouch.runasp.net/api/Media/upload',
        data: _buildFormData(), // ← instance جديدة تانية للـ retry
      );
      if (retryResponse.data == null) {
        throw Exception("Server returned empty response after token refresh");
      }
      final fullUrl = "https://entouch.runasp.net" + retryResponse.data['url'];
      return fullUrl;
    }
    throw Exception("Upload failed: ${e.message}");
  }
}

  Future<bool> refreshToken() async {
    try {
      final userModel = HiveCacheHelper.getData<AuthModel>("authData");
      String? token = userModel?.refreshToken;
      if (token == null) {
        return false;
      }
      final response = await Dio().post(
        'https://entouch.runasp.net/api/Auth/refresh',
        data: {'refreshToken': userModel?.refreshToken ?? ""},
      );
      final updatedUser = AuthModel(
        token: response.data['accessToken'],
        refreshToken: response.data['refreshToken'],
        email: userModel?.email ?? "",
        fullName: userModel?.fullName ?? "",
        id: userModel?.id ?? "",
        isDeaf: userModel?.isDeaf ?? false,
        isMute: userModel?.isMute ?? false,
        preferredLanguage: userModel?.preferredLanguage ?? "",
      );

      await HiveCacheHelper.saveData<AuthModel>('authData', updatedUser);
      HiveCacheHelper.getData<AuthModel>('authData');
      await AuthRepoImpl().sendFcmToken(fcmToken: HiveCacheHelper.getData("messageToken")!);
      return true;
    } on DioException catch (e) {
      print(e);
      return false;
    } catch (e) {
      return false;
    }
  }
}
