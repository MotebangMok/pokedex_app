import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_app/data/data_source/local_data_source/local_data_source.dart';
import 'package:pokedex_app/di/service_locator.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  final LocalDataSource localDataSource;
  ThemeNotifier(this.localDataSource) : super(ThemeMode.light) {
    _getTheme();
  }

  Future<void> _getTheme() async {
    final isDark = await localDataSource.getThemeMode();
    if (isDark) {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.light;
    }
  }

  Future<void> toggleTheme(bool isOn) async {
    final isDarkMode = state == ThemeMode.dark;
    if (isDarkMode) {
      state = ThemeMode.light;
    } else {
      state = ThemeMode.dark;
    }
    await localDataSource.saveThemeMode(isOn);
  }

  final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
    return ThemeNotifier(getIt<LocalDataSource>());
  });
}
