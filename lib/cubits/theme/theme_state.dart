part of 'theme_cubit.dart';

@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState.system() = System;
  const factory ThemeState.light() = Light;
  const factory ThemeState.dark() = Dark;

  static ThemeState fromMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return const ThemeState.system();
      case ThemeMode.light:
        return const ThemeState.light();
      case ThemeMode.dark:
        return const ThemeState.dark();
    }
  }
}
