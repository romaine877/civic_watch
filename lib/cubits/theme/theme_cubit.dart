import 'package:bloc/bloc.dart';
import 'package:civic_watch/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../services/local_storage_service.dart';

part 'theme_state.dart';
part 'theme_cubit.freezed.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState.system()) {
    getCurrentTheme();
  }

  final pref = getIt<LocalStorageService>();

  void toggleTheme(ThemeMode? mode) {
    if (mode == null) return;
    pref.saveData(LSKey.themeMode, mode.toString().split('.').last);
    emit(ThemeState.fromMode(mode));
  }

  void getCurrentTheme() {
    pref.getString(LSKey.themeMode).then((theme) {
      if (theme == 'dark') {
        emit(const ThemeState.dark());
      } else if (theme == 'light') {
        emit(const ThemeState.light());
      } else {
        emit(const ThemeState.system());
      }
    });
  }
}
