import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:en_touch/core/api/end_points.dart';
import 'package:en_touch/core/services/app_services.dart';
import 'package:en_touch/features/inverse%20camera/data/models/inverse-camera_sign_to_text_model.dart';
import 'package:en_touch/features/inverse%20camera/data/repo/inverse_camera_repo_impl.dart';
import 'package:en_touch/features/inverse%20camera/domain/use%20cases/audio_use_case.dart';
import 'package:en_touch/features/inverse%20camera/domain/use%20cases/result_audio_use_case.dart';
import 'package:en_touch/features/inverse%20camera/domain/use%20cases/send_video_use_case.dart';
import 'package:en_touch/features/inverse%20camera/domain/use%20cases/translation_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:video_player/video_player.dart';
part 'inverse_camera_state.dart';

class InverseCameraCubit extends Cubit<InverseCameraState> {
  InverseCameraCubit() : super(InverseCameraInitial());

    InverseCameraTranslationUseCase translationUseCase = InverseCameraTranslationUseCase();
  ImagePicker imagePicker = ImagePicker();
  VideoPlayerController? videoPlayerController;
  VideoPlayerController? resultVideoPlayerController;
  InverseCameraAudioUseCase audioUseCase = InverseCameraAudioUseCase();
  InverseCameraSendVideoUseCase sendVideoUseCase = InverseCameraSendVideoUseCase();
  InverseCameraResultAudioUseCase resultAudioUseCase = InverseCameraResultAudioUseCase();
  TextEditingController answerTextController = TextEditingController();
  InverseCameraRepoImpl repository = InverseCameraRepoImpl();
  FlutterTts flutterTts = FlutterTts();
  AppServices appServices = AppServices();
  String translationText = '';
  String recordedAnswer = '';
  String answerTYPE = "";
  int tabIndex = 0;
  String error = '';
  TextEditingController sendResultTextController = TextEditingController();
  bool isPlaying = false;
  bool isSaved = false;
  bool showTransAndAudio = false;
  bool isPickingVideo = false;
  String? videoPath;
  String? lastVideo;
  String urlVideo = "";
  late InverseCameraSignToTextModel videoFile;
  EndPoints endpoint = EndPoints();
  String? resultVideoPath;
  String? resultText;

  void changeTab(int index) {
    tabIndex = 1;
    emit(ChangeTab());
  }

  void translation(String text) async {
    emit(InverseTranslationLoading());
    try {
      final result = await translationUseCase.call(text);
      translationText = result;
      emit(InverseTranslationSuccess());
    } catch (e) {
      emit(InverseTranslationError(e.toString()));
    }
  }

  void audio(String text) async {
    emit(InverseAudioLoading());
    try {
      await audioUseCase.call(text);
      isPlaying = true;
      emit(InverseAudioSuccess());
    } catch (e) {
      error = e.toString();
      emit(InverseAudioError(error));
    }
  }


  void saveToHistory() {
    isSaved = true;
    emit(InverseSaveToHistory());
  }



// Future<void> chooseVideoFromGallery() async {
//   try {
//     final List<File> videos = await appServices.chooseVideoFromGalleryAsFile();
//     if (videos.isEmpty) return;

//     emit(InverseSendVideoLoading());

//     for (final video in videos) {
//       videoFile = await sendVideoUseCase.call(video);
//       videoPath = await appServices.uploadToServer(video.path);
//       tabIndex = 1;
//       await syncVideo(videoPath);
//     }

//     emit(InverseSendVideoSuccess());
//   } catch (e) {
//     print('Error in chooseVideoFromGallery: ${e.toString()}');
//     if (isClosed) return;
//     emit(InverseSendVideoError(e.toString()));
//   }
// }
  Future<void> chooseVideoFromGallery() async {
    try {
      final File? startVideo = await appServices.chooseVideoFromGalleryAsFile();
      if (startVideo == null) {
        return;
      }
      emit(InverseSendVideoLoading());
      videoFile = await sendVideoUseCase.call(startVideo);
      videoPath = await appServices.uploadToServer(startVideo.path);
      tabIndex = 1;
      await syncVideo(videoPath);
      emit(InverseSendVideoSuccess());
    } catch (e) {
      if (isClosed) return;
      emit(InverseSendVideoError(e.toString()));
    }
  }


  Future<void> startVideoFromCamera() async {
    try {
      final File? startVideo = await appServices.startVideoFromCameraAsFile();
      if (startVideo == null || startVideo.path.isEmpty) {
        return;
      }
      emit(InverseSendVideoLoading());
      videoFile = await sendVideoUseCase.call(startVideo);
      videoPath = await appServices.uploadToServer(startVideo.path);
      tabIndex = 1;
      await syncVideo(videoPath);
      emit(InverseSendVideoSuccess());
    } catch (e) {
      if (isClosed) return;
      emit(InverseSendVideoError(e.toString()));
    }
  }


  Future<void> syncVideo(String? path) async {
  if (path == null || path.isEmpty || path == lastVideo) return;
  lastVideo = path;
  await videoPlayerController?.dispose();
  final uri = Uri.tryParse(path);
  if (uri != null && (uri.scheme == 'http' || uri.scheme == 'https')) {
    videoPlayerController = VideoPlayerController.networkUrl(
      uri,
      httpHeaders: {
        'Authorization': 'Bearer ${appServices.userModel?.token ?? ""}',
      },
    );
  } else {
    videoPlayerController = VideoPlayerController.file(File(path));
  }
  await videoPlayerController!.initialize();
  await videoPlayerController!.play();
  emit(InversePlayVideoSuccess());
}

  void showTransAndAudioWidget() {
    showTransAndAudio = true;
    emit(InverseShowTransAndAudioWidget());
  }

  Future<void> playVideo(String videoPath) async {
    try {
      if (videoPlayerController != null) {
        if (videoPlayerController!.value.isPlaying) {
          await videoPlayerController!.pause();
        } else {
          await videoPlayerController!.play();
        }
      } else {
        await syncVideo(videoPath);
      }
      if (isClosed) return;
      emit(InversePlayVideoSuccess());
    } catch (e) {
      if (isClosed) return;
      error = e.toString();
      emit(InversePlayVideoError(error));
    }
  }

  void chooseAnswerType(String answerType) {
    answerTYPE = answerType;
    emit(InverseChooseAnswerType());
  }

  Future<void> answerText(String text) async {
    try {
      await repository.answerText(text);
      emit(InverseAnswerTextState());
    } catch (e) {
      error = e.toString();
      emit(InversePlayVideoError(error));
    }
  }

  Future<void> answerRecord() async {
    try {
      final String? recognizedText = await repository.answerWithRecord();
      if (recognizedText != null && recognizedText.trim().isNotEmpty) {
        recordedAnswer = recognizedText.trim();
      }
      emit(InverseAnswerRecordState(recordedAnswer));
    } catch (e) {
      error = e.toString();
      emit(InversePlayVideoError(error));
    }
  }

  @override
  Future<void> close() async {
    await videoPlayerController?.dispose();
    await flutterTts.stop();
    answerTextController.dispose();
    return super.close();
  }

  Future<void> saveHistory(String inputText) async {
    emit(InverseSaveHistoryLoading());
    try {
      await repository.saveHistory(inputText);
      isSaved = true;
      emit(InverseSaveHistorySuccess());
    } catch (e) {
      error = e.toString();
      emit(InverseSaveHistoryError(error));
    }
  }

  Future<void> sendResultText(String resultText) async {
    emit(InverseSendResultLoading());
    try {
      var response = await repository.sendResult(resultText);
      resultVideoPath = "${endpoint.showVideos}${response.outputVideoUrl}";
      this.resultText = response.inputText ?? '';
      emit(InverseSendResultSuccess());
    } catch (e) {
      error = e.toString();
      emit(InverseSendResultError(error));
    } }

    Future<void> sendResultAudio() async {
    try {
      String? audioToText = await resultAudioUseCase.call();
      emit(InverseSendResultLoading());
      if(audioToText != null){
        var response = await repository.sendResult(audioToText);
      resultVideoPath = "${endpoint.showVideos}${response.outputVideoUrl}";
      resultText = response.inputText ?? '';
      }
      emit(InverseSendResultSuccess());
    } catch (e) {
      error = e.toString();
      emit(InverseSendResultError(error));
    } }



}


