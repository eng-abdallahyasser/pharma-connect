import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsService extends GetxService {
  static const String _darkModeKey = 'isDarkMode';
  static const String _notificationsKey = 'notificationsEnabled';
  static const String _languageKey = 'currentLanguage';

  final _storage = GetStorage();

  final _isDarkMode = false.obs;
  final _notificationsEnabled = true.obs;
  final _currentLanguage = 'en'.obs;

  // Getters
  bool get isDarkMode => _isDarkMode.value;
  bool get notificationsEnabled => _notificationsEnabled.value;
  String get currentLanguage => _currentLanguage.value;

  // Observable getters for reactive UI
  RxBool get isDarkModeRx => _isDarkMode;
  RxBool get notificationsEnabledRx => _notificationsEnabled;
  RxString get currentLanguageRx => _currentLanguage;

  @override
  void onInit() async{
    super.onInit();
    log('SettingsService.onInit() - Loading all settings');
     _loadAllSettings();
  }

  /// Load all settings from storage
  void _loadAllSettings() {
    _loadDarkMode();
    _loadNotifications();
    _loadLanguage();
    log('All settings loaded: ${getAllSettings()}');
  }

  /// Load dark mode preference
  void _loadDarkMode() {
    final savedDarkMode = _storage.read(_darkModeKey) ?? false;
    _isDarkMode.value = savedDarkMode;
    log('Loaded dark mode: $savedDarkMode from storage key: $_darkModeKey');
  }

  /// Load notifications preference
  void _loadNotifications() {
    final savedNotifications = _storage.read(_notificationsKey) ?? true;
    _notificationsEnabled.value = savedNotifications;
    log(
      'Loaded notifications: $savedNotifications from storage key: $_notificationsKey',
    );
  }

  /// Load language preference
  void _loadLanguage() {
    final savedLanguage = _storage.read(_languageKey) ?? 'en';
    _currentLanguage.value = savedLanguage;
    log('Loaded language: $savedLanguage from storage key: $_languageKey');
  }

  /// Toggle dark mode
  void toggleDarkMode() {
    _isDarkMode.value = !_isDarkMode.value;
    _saveDarkMode();
  }

  /// Set dark mode explicitly
  void setDarkMode(bool isDark) {
    _isDarkMode.value = isDark;
    _saveDarkMode();
  }

  /// Save dark mode preference
  void _saveDarkMode() {
    _storage.write(_darkModeKey, _isDarkMode.value);
    log('Saved dark mode: ${_isDarkMode.value} to storage key: $_darkModeKey');
    log('Verify read back: ${_storage.read(_darkModeKey)}');
  }

  /// Toggle notifications
  void toggleNotifications() {
    _notificationsEnabled.value = !_notificationsEnabled.value;
    _saveNotifications();
  }

  /// Set notifications explicitly
  void setNotifications(bool enabled) {
    _notificationsEnabled.value = enabled;
    _saveNotifications();
  }

  /// Save notifications preference
  void _saveNotifications() {
    _storage.write(_notificationsKey, _notificationsEnabled.value);
    log(
      'Saved notifications: ${_notificationsEnabled.value} to storage key: $_notificationsKey',
    );
    log('Verify read back: ${_storage.read(_notificationsKey)}');
  }

  /// Set language
  void setLanguage(String languageCode) {
    _currentLanguage.value = languageCode;
    _saveLanguage();
  }

  /// Save language preference
  void _saveLanguage() {
    _storage.write(_languageKey, _currentLanguage.value);
    log(
      'Saved language: ${_currentLanguage.value} to storage key: $_languageKey',
    );
    log('Verify read back: ${_storage.read(_languageKey)}');
  }

  /// Get all settings as a map
  Map<String, dynamic> getAllSettings() {
    return {
      'darkMode': isDarkMode,
      'notifications': notificationsEnabled,
      'language': currentLanguage,
    };
  }

  /// Reset all settings to defaults
  Future<void> resetAllSettings() async {
    await _storage.remove(_darkModeKey);
    await _storage.remove(_notificationsKey);
    await _storage.remove(_languageKey);
    log('All settings reset to defaults');
    _loadAllSettings();
  }

  /// Debug: Print all stored data
  void printStorageDebugInfo() {
    log('========== STORAGE DEBUG INFO ==========');
    log('All storage keys: ${_storage.getKeys()}');
    log('isDarkMode value: ${_storage.read(_darkModeKey)}');
    log('notificationsEnabled value: ${_storage.read(_notificationsKey)}');
    log('currentLanguage value: ${_storage.read(_languageKey)}');
    log('Current observables: ${getAllSettings()}');
    log('========================================');
  }
}
