import 'package:bloc/bloc.dart';
import 'package:en_touch/core/cache/hive_cach_helper.dart';
import 'package:en_touch/features/dictionary/presentation/screen/dictionary_screen.dart';
import 'package:en_touch/features/history/presentation/screen/history_screen.dart';
import 'package:en_touch/features/home/presentation/screen/home_screen.dart';
import 'package:en_touch/features/setting/presentation/screen/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  int currentIndex = 0;

  List<Widget> tabs = [
    HomeScreen(),
    HistoryScreen(),
    DictionaryScreen(),
    SettingScreen(),
  ];

  void changeTab(int index) {
    currentIndex = index;
    HiveCacheHelper.saveData("mainTabIndex", currentIndex);
    emit(MainChangeTab());
  }
}
