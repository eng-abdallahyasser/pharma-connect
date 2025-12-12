import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'settings_service.dart';

class ThemeService extends GetxService {
  late SettingsService _settingsService;
  final _isDarkMode = false.obs;

  bool get isDarkMode => _isDarkMode.value;
  RxBool get isDarkModeRx => _isDarkMode;

  @override
  void onInit() {
    super.onInit();
    _settingsService = Get.find<SettingsService>();
    _syncWithSettings();
  }

  /// Sync dark mode state from SettingsService
  void _syncWithSettings() {
    _isDarkMode.value = _settingsService.isDarkMode;
    _applyTheme(_isDarkMode.value);
  }

  /// Toggle dark mode
  void toggleDarkMode() {
    _isDarkMode.value = !_isDarkMode.value;
    _settingsService.setDarkMode(_isDarkMode.value);
    _applyTheme(_isDarkMode.value);
  }

  /// Apply theme to the app
  void _applyTheme(bool isDark) {
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  /// Set dark mode explicitly
  void setDarkMode(bool isDark) {
    _isDarkMode.value = isDark;
    _settingsService.setDarkMode(isDark);
    _applyTheme(isDark);
  }
}
