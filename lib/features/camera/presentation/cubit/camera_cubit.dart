import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:en_touch/core/api/end_points.dart';
import 'package:en_touch/core/services/app_services.dart';
import 'package:en_touch/features/camera/data/model/sign_to_text_model.dart';
import 'package:en_touch/features/camera/data/repo/camera_repo_impl.dart';
import 'package:en_touch/features/camera/domain/repo/camera_repo.dart';
import 'package:en_touch/features/camera/domain/use_case/audio_use_case.dart';
import 'package:en_touch/features/camera/domain/use_case/result_audio_use_case.dart';
import 'package:en_touch/features/camera/domain/use_case/send_video_use_case.dart';
import 'package:en_touch/features/camera/domain/use_case/translation_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

part 'camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(CameraInitial());

  
  TranslationUseCase translationUseCase = TranslationUseCase();
  ImagePicker imagePicker = ImagePicker();
  VideoPlayerController? videoPlayerController;
  VideoPlayerController? resultVideoPlayerController;
  AudioUseCase audioUseCase = AudioUseCase();
  SendVideoUseCase sendVideoUseCase = SendVideoUseCase();
  ResultAudioUseCase resultAudioUseCase = ResultAudioUseCase();
  TextEditingController answerTextController = TextEditingController();
  CameraRepo repository = CameraRepoImpl();
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
  late SignToTextModel videoFile;
  EndPoints endpoint = EndPoints();
  String? resultVideoPath;
  String? resultText;

  void changeTab(int index) {
    tabIndex = 1;
    emit(ChangeTab());
  }

  void translation(String text) async {
    emit(TranslationLoading());
    try {
      final result = await translationUseCase.call(text);
      translationText = result;
      emit(TranslationSuccess());
    } catch (e) {
      emit(TranslationError(e.toString()));
    }
  }

  void audio(String text) async {
    emit(AudioLoading());
    try {
      await audioUseCase.call(text);
      isPlaying = true;
      emit(AudioSuccess());
    } catch (e) {
      error = e.toString();
      emit(AudioError(error));
    }
  }

  

  void saveToHistory() {
    isSaved = true;
    emit(SaveToHistory());
  }

//    Future<void> chooseVideoFromGallery() async {
//   try {
//     final List<File> videos = await appServices.chooseVideoFromGalleryAsFile();
//     if (videos.isEmpty) return;

//     emit(SendVideoLoading());

//     for (final video in videos) {
//       videoFile = await sendVideoUseCase.call(video);
//       videoPath = await appServices.uploadToServer(video.path);
//       tabIndex = 1;
//       await syncVideo(videoPath);
//     }

//     emit(SendVideoSuccess());
//   } catch (e) {
//     if (isClosed) return;
//     emit(SendVideoError(e.toString()));
//   }
// }


  Future<void> chooseVideoFromGallery() async {
    try {
      final File? startVideo = await appServices.chooseVideoFromGalleryAsFile();
      if (startVideo == null || startVideo.path.isEmpty) {
        return;
      }
      emit(SendVideoLoading());
      videoFile = await sendVideoUseCase.call(startVideo);
      videoPath = await appServices.uploadToServer(startVideo.path);
      tabIndex = 1;
      await syncVideo(videoPath);
      emit(SendVideoSuccess());
    } catch (e) {
      if (isClosed) return;
      emit(SendVideoError(e.toString()));
    }
  }

  Future<void> startVideoFromCamera() async {
    try {
      final File? startVideo = await appServices.startVideoFromCameraAsFile();
      if (startVideo == null || startVideo.path.isEmpty) {
        return;
      }
      emit(SendVideoLoading());
      videoFile = await sendVideoUseCase.call(startVideo);
      videoPath = await appServices.uploadToServer(startVideo.path);
      tabIndex = 1;
      await syncVideo(videoPath);
      emit(SendVideoSuccess());
    } catch (e) {
      if (isClosed) return;
      emit(SendVideoError(e.toString()));
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
  emit(PlayVideoSuccess());
}

  void showTransAndAudioWidget() {
    showTransAndAudio = true;
    emit(ShowTransAndAudioWidget());
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
      emit(PlayVideoSuccess());
    } catch (e) {
      if (isClosed) return;
      error = e.toString();
      emit(PlayVideoError(error));
    }
  }

  void chooseAnswerType(String answerType) {
    answerTYPE = answerType;
    emit(ChooseAnswerType());
  }

  Future<void> answerText(String text) async {
    try {
      await repository.answerText(text);
      emit(AnswerTextState());
    } catch (e) {
      error = e.toString();
      emit(PlayVideoError(error));
    }
  }

  Future<void> answerRecord() async {
    try {
      final String? recognizedText = await repository.answerWithRecord();
      if (recognizedText != null && recognizedText.trim().isNotEmpty) {
        recordedAnswer = recognizedText.trim();
      }
      emit(AnswerRecordState(recordedAnswer));
    } catch (e) {
      error = e.toString();
      emit(PlayVideoError(error));
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
    emit(SaveHistoryLoading());
    try {
      await repository.saveHistory(inputText);
      isSaved = true;
      emit(SaveHistorySuccess());
    } catch (e) {
      error = e.toString();
      emit(SaveHistoryError(error));
    }
  }

  Future<void> sendResultText(String resultText) async {
    emit(SendResultLoading());
    try {
      var response = await repository.sendResult(resultText);
      resultVideoPath = "${endpoint.showVideos}${response.outputVideoUrl}";
      this.resultText = response.inputText ?? '';
      emit(SendResultSuccess());
    } catch (e) {
      error = e.toString();
      emit(SendResultError(error));
    } }

    Future<void> sendResultAudio() async {
    try {
      String? audioToText = await resultAudioUseCase.call();
      emit(SendResultLoading());
      if(audioToText != null){
        var response = await repository.sendResult(audioToText);
      resultVideoPath = "${endpoint.showVideos}${response.outputVideoUrl}";
      resultText = response.inputText ?? '';
      }
      emit(SendResultSuccess());
    } catch (e) {
      error = e.toString();
      emit(SendResultError(error));
    } }



}
