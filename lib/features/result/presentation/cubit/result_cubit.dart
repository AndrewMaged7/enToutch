import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:en_touch/core/services/app_services.dart';
import 'package:en_touch/features/camera/data/model/save_history_model.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

part 'result_state.dart';

class ResultCubit extends Cubit<ResultState> {
  ResultCubit() : super(ResultInitial());
  VideoPlayerController? videoPlayerController;
  AppServices appServices = AppServices();
  String? lastVideo;
  var videoPath;
  var resultText;
  SaveHistoryModel? saveHistoryModel;

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
    } catch (e) {
      if (isClosed) return;
      emit(ResultError(e.toString()));
    }
  }


  Future<void> syncVideo(String? path) async {
  emit(ResultLoading());
  if (path == null || path.isEmpty || path == lastVideo) return;
  lastVideo = path;
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
  emit(ResultSuccess());
}



Future<void> saveToDevice(String url) async {
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




}
