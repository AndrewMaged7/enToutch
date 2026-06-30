import 'package:bloc/bloc.dart';
import 'package:en_touch/core/cache/hive_cach_helper.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
    : isDark = HiveCacheHelper.getData<bool>('theme') ?? false,
      super(ThemeInitial());
  bool isDark;

  Future<void> changeTheme(bool isDark) async {
    this.isDark = isDark;
    await HiveCacheHelper.saveData<bool>('theme', isDark);
    emit(ThemeChanged());
  }
}
