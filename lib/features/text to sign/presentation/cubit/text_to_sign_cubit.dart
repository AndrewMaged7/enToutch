import 'dart:io';import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:en_touch/core/api/end_points.dart';
import 'package:en_touch/core/services/app_services.dart';
import 'package:en_touch/features/text%20to%20sign/data/model/extract_audio_from_video_model.dart';
import 'package:en_touch/features/text%20to%20sign/data/model/text_to_sign_model.dart';
import 'package:en_touch/features/text%20to%20sign/domain/use%20case/get_text_to_sign_video_use_case.dart';
import 'package:en_touch/features/text%20to%20sign/domain/use%20case/text_to_sign_use_case.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

part 'text_to_sign_state.dart';

class TextToSignCubit extends Cubit<TextToSignState> {
  TextEditingController textController = TextEditingController();
  TextToSignUseCase textToSignUseCase = TextToSignUseCase();
  GetTextToSignVideoUseCase getTextToSignVideoUseCase = GetTextToSignVideoUseCase();
  TextToSignCubit() : super(TextToSignInitial());
  AppServices appServices = AppServices();
  EndPoints endpoint = EndPoints();
  TextToSignModel? textToSignModel;
  ExtractAudioFromVideoModel? extractAudioModel;
  VideoPlayerController? videoPlayerController;
  String? lastVideo;
  String? videoUrl;
  var video;

  Future<void> sendText(String text) async {
    emit(TextToSignLoading());
    try {
      textToSignModel = await textToSignUseCase.sendText(text);
      videoUrl = "${endpoint.showVideos}${textToSignModel?.outputVideoUrl}";
      await syncVideo(videoUrl);
      emit(TextToSignSuccess());
    } catch (e) {
      emit(TextToSignError(e.toString()));
    }
  }

   Future<void> syncVideo(String? path) async {
  if (path == null || path.isEmpty || path == lastVideo){
    emit(TextToSignError("Invalid video path"));
    return;
  }
  await videoPlayerController?.dispose();
  final uri = Uri.tryParse(path);
  if (uri != null && (uri.scheme == 'http' || uri.scheme == 'https')) {
    videoPlayerController = VideoPlayerController.networkUrl(
      uri,
    );
  } else {
    videoPlayerController = VideoPlayerController.file(File(path));
  }
  await videoPlayerController!.initialize();
  await videoPlayerController!.play();
  emit(TextToSignSuccess());
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
      emit(TextToSignSuccess());
    } catch (e) {
      if (isClosed) return;
      emit(TextToSignError(e.toString()));
    }
  }

Future<void> saveToDevice(String url) async {
  emit(SaveToGalleryLoading());
  try {
    final dir = await getTemporaryDirectory();
    final filePath =
        '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';
    await Dio().download(url, filePath);
    await ImageGallerySaverPlus.saveFile(filePath);
    emit(SaveToGallerySuccess());
  } catch (e) {
    emit(SaveToGalleryError(e.toString()));
  }
}


Future<void> fromVideoToSign() async {
  try {
    video = await appServices.chooseVideoFromGalleryAsFile();
    if (video == null || video.path.isEmpty) {
      return;
    }
    emit(VideoToSignLoading());
    extractAudioModel =
        await getTextToSignVideoUseCase.call(video);
    final text = extractAudioModel?.transcribedText;
    if (text == null || text.isEmpty) {
      emit(VideoToSignError("No text extracted"));
      return;
    }
    textToSignModel =
        await textToSignUseCase.sendText(text);
    videoUrl =
        "${endpoint.showVideos}${textToSignModel!.outputVideoUrl}";
    await syncVideo(videoUrl);
    emit(VideoToSignSuccess());
  } catch (e) {
    emit(VideoToSignError(e.toString()));
  }
}



Future<bool> pickVideo() async {
  video = await appServices.chooseVideoFromGalleryAsFile();
  return video != null && video.path.isNotEmpty;
}

Future<void> processVideoToSign() async {
  try {
    emit(VideoToSignLoading());
    extractAudioModel = await getTextToSignVideoUseCase.call(video);
    final text = extractAudioModel?.transcribedText;
    if (text == null || text.isEmpty) {
      emit(VideoToSignError("No text extracted"));
      return;
    }
    textToSignModel = await textToSignUseCase.sendText(text);
    videoUrl = "${endpoint.showVideos}${textToSignModel!.outputVideoUrl}";
    await syncVideo(videoUrl);
    emit(VideoToSignSuccess());
  } catch (e) {
    emit(VideoToSignError(e.toString()));
  }
}


}