import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:en_touch/core/cache/hive_cach_helper.dart';
import 'package:en_touch/features/learn%20new%20sign/domain/use%20case/save_history.dart';
import 'package:meta/meta.dart';
import 'package:video_player/video_player.dart';

part 'learn_new_sign_state.dart';

class LearnNewSignCubit extends Cubit<LearnNewSignState> {
  LearnNewSignCubit() : super(LearnNewSignInitial());
  SaveHistoryUseCase saveToHistoryUseCase = SaveHistoryUseCase();

  VideoPlayerController? videoPlayerController;
  String? lastVideo;
  bool isSaved = false;

  List<String> texts = [
    "thin","cool","before","go","drink","who","help","cousin","computer","trade","thanksgiving","tall","short","candy","bowling","bed","accident","yes","what","shirt"
  ];

  List<String> images = [
    "https://i.ytimg.com/vi/Ioot4ZteOIg/hqdefault.jpg",
    "https://i.ytimg.com/vi/Ow4vhGkdBIQ/hqdefault.jpg",
    "https://i.ytimg.com/vi/trmVwvA2tK8/hqdefault.jpg",
    "https://i.ytimg.com/vi/TMVULNk8eJY/hqdefault.jpg",
    "https://i.ytimg.com/vi/kc_aUHdL8Nw/hqdefault.jpg",
    "https://i.ytimg.com/vi/KIaDS9zkFpY/hqdefault.jpg",
    "https://i.ytimg.com/vi/bs82lxSLPFQ/hqdefault.jpg",
    "https://i.ytimg.com/vi/AF4FkqPVbYA/hqdefault.jpg",
    "https://i.ytimg.com/vi/DxflVxX3U94/hqdefault.jpg",
    "https://i.ytimg.com/vi/A0_B8ZK-nC4/hqdefault.jpg",
    "https://i.ytimg.com/vi/BGWPt7AAask/hqdefault.jpg",
    "https://i.ytimg.com/vi/d4ifXGuNFe4/hqdefault.jpg",
    "https://i.ytimg.com/vi/_LkOjUec6Qk/hqdefault.jpg",
    "https://i.ytimg.com/vi/dQlLcUf4mYM/hqdefault.jpg",
    "https://i.ytimg.com/vi/Pk606Hbau_M/hqdefault.jpg",
    "https://i.ytimg.com/vi/6FqH8rduhsI/hqdefault.jpg",
    "https://i.ytimg.com/vi/IYj4JGrhZ8o/hqdefault.jpg",
    "https://i.ytimg.com/vi/S42k0eTQ7zM/hqdefault.jpg",
    "https://i.ytimg.com/vi/_LkOjUec6Qk/hqdefault.jpg",
    "https://i.ytimg.com/vi/Dmm6Mya9UY4/hqdefault.jpg",
  ];

  String baseUrl = "https://www.youtube.com/watch?v=";

  List<String> videoId = [
    "Ioot4ZteOIg",
    "Ow4vhGkdBIQ",
    "trmVwvA2tK8",
    "TMVULNk8eJY",
    "kc_aUHdL8Nw",
    "KIaDS9zkFpY",
    "bs82lxSLPFQ",
    "AF4FkqPVbYA",
    "DxflVxX3U94",
    "A0_B8ZK-nC4",
    "BGWPt7AAask",
    "d4ifXGuNFe4",
    "_LkOjUec6Qk",
    "dQlLcUf4mYM",
    "Pk606Hbau_M",
    "6FqH8rduhsI",
    "IYj4JGrhZ8o",
    "S42k0eTQ7zM",
    "_LkOjUec6Qk",
    "Dmm6Mya9UY4",
  ];

List<bool> savedItems = List.filled(20, false);



Future<void> syncVideo(String? path) async {
  emit(LearnNewSignLoading());
  if (path == null || path.isEmpty || path == lastVideo){
    emit(LearnNewSignError("Invalid video path"));
    return;
  }
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
  emit(LearnNewSignSuccess());
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
      emit(LearnNewSignSuccess());
    } catch (e) {
      if (isClosed) return;
      emit(LearnNewSignError(e.toString()));
    }
  }


  Future<void> saveHistory(String inputText, int index) async {
    emit(SaveHistoryLoading());
    try {
      await saveToHistoryUseCase(inputText);
      savedItems[index] = true;
      await HiveCacheHelper.saveData<List>("savedItems", savedItems);
      emit(SaveHistorySuccess());
    } catch (e) {
      emit(SaveHistoryError(e.toString()));
    }
  }
void loadSavedItems() {
  final saved = HiveCacheHelper.getData<List>("savedItems");
  if (saved != null) {
    savedItems = saved.map((e) => e as bool).toList();
  }
  emit(LearnNewSignInitial());
}

}
