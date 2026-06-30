import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:en_touch/core/services/app_services.dart';
import 'package:en_touch/features/dictionary/data/models/dic_model.dart';
import 'package:en_touch/features/dictionary/domain/use_case/dic_use_case.dart';
import 'package:en_touch/features/dictionary/domain/use_case/translation_use_case.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

part 'dictionary_state.dart';

class DictionaryCubit extends Cubit<DictionaryState> {
  DictionaryCubit() : super(DictionaryInitial());

  DicUseCase dicUseCase = DicUseCase();
  YoutubePlayerController controller = YoutubePlayerController();
  List<YoutubeVideoModel>? youtubeVideoModel;
  AppServices appServices = AppServices();
  String? recordText;
  Timer? timer;
  StreamSubscription<Duration>? positionSubscription;

  TextEditingController text = TextEditingController();
  DicTranslationUseCase translationUseCase = DicTranslationUseCase();
  bool visable = false;

  Future<void> getDictionaryData(String inputText) async {
    try {
      youtubeVideoModel = await dicUseCase.getDictionaryData("AIzaSyA3hq6BkI2P0JskAzjfdzPM68hXLPqLCoo", inputText);
      visable = true;
      emit(DictionarySuccess());
    } catch (e) {
      emit(DictionaryError(e.toString()));
    }
  }

  Future<void> recordToText() async {
    try {
      emit(RecordLoading());
      final result = await translationUseCase.call();
      recordText = result;
      getDictionaryData(recordText ?? "");
       visable = true;
      emit(RecordSuccess());
    } catch (e) {
      emit(RecordError(e.toString()));
    }
  }
   

   void playFirstMinute(String videoId) {
  positionSubscription?.cancel();

  controller = YoutubePlayerController.fromVideoId(
    videoId: videoId,
    autoPlay: true,
  );

  positionSubscription =
      controller.getCurrentPositionStream().listen((position) {
    if (position.inSeconds >= 60) {
      controller.pauseVideo();
      controller.seekTo(seconds: 0);
    }
  });
}

@override
Future<void> close() {
  timer?.cancel();
  positionSubscription?.cancel();
  controller.close();
  return super.close();
}

   
  }

