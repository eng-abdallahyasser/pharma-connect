import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Localization Service to manage app languages and translations
/// 
/// This service handles:
/// - Language switching (English/Arabic)
/// - Locale management
/// - Translation retrieval
/// - Language persistence
class LocalizationService extends GetxService {
  // Observable for current language
  final Rx<Locale> locale = const Locale('en').obs;
  
  // Observable for current language code
  final RxString currentLanguage = 'en'.obs;
  
  // Observable for text direction (LTR for English, RTL for Arabic)
  final RxBool isRTL = false.obs;

  // Supported locales
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ar'),
  ];

  // Language names
  static const Map<String, String> languageNames = {
    'en': 'English',
    'ar': 'العربية',
  };

  @override
  void onInit() {
    super.onInit();
    // Initialize with device locale or fallback to English
    _initializeLocale();
  }

  /// Initialize locale from device settings or saved preference
  void _initializeLocale() {
    // Try to get device locale
    final deviceLocale = Get.deviceLocale;
    
    if (deviceLocale != null && 
        supportedLocales.any((l) => l.languageCode == deviceLocale.languageCode)) {
      setLanguage(deviceLocale.languageCode);
    } else {
      // Default to English
      setLanguage('en');
    }
  }

  /// Change app language
  /// 
  /// Parameters:
  /// - [languageCode]: 'en' for English, 'ar' for Arabic
  void setLanguage(String languageCode) {
    if (!supportedLocales.any((l) => l.languageCode == languageCode)) {
      return; // Invalid language code
    }

    currentLanguage.value = languageCode;
    locale.value = Locale(languageCode);
    isRTL.value = languageCode == 'ar';

    // Update Get locale
    Get.updateLocale(Locale(languageCode));

    // Persist language preference
    _saveLanguagePreference(languageCode);
  }

  /// Toggle between English and Arabic
  void toggleLanguage() {
    final newLanguage = currentLanguage.value == 'en' ? 'ar' : 'en';
    setLanguage(newLanguage);
  }

  /// Get current language code
  String getCurrentLanguage() {
    return currentLanguage.value;
  }

  /// Get current language name
  String getCurrentLanguageName() {
    return languageNames[currentLanguage.value] ?? 'English';
  }

  /// Check if current language is Arabic
  bool isArabic() {
    return currentLanguage.value == 'ar';
  }

  /// Check if current language is English
  bool isEnglish() {
    return currentLanguage.value == 'en';
  }

  /// Get TextAlign based on current language direction
  TextAlign getTextAlign([TextAlign defaultAlign = TextAlign.start]) {
    if (isRTL.value) {
      return defaultAlign == TextAlign.start 
          ? TextAlign.end 
          : defaultAlign == TextAlign.end 
          ? TextAlign.start 
          : defaultAlign;
    }
    return defaultAlign;
  }

  /// Get AlignmentGeometry based on current language direction
  AlignmentGeometry getAlignment(AlignmentGeometry ltrAlignment) {
    if (isRTL.value) {
      // Mirror the alignment for RTL
      if (ltrAlignment == Alignment.centerLeft) return Alignment.centerRight;
      if (ltrAlignment == Alignment.centerRight) return Alignment.centerLeft;
      if (ltrAlignment == Alignment.topLeft) return Alignment.topRight;
      if (ltrAlignment == Alignment.topRight) return Alignment.topLeft;
      if (ltrAlignment == Alignment.bottomLeft) return Alignment.bottomRight;
      if (ltrAlignment == Alignment.bottomRight) return Alignment.bottomLeft;
    }
    return ltrAlignment;
  }

  /// Save language preference to local storage
  void _saveLanguagePreference(String languageCode) {
    // TODO: Save to SharedPreferences
    // await _prefs.setString('language', languageCode);
  }

  /// Get supported languages list
  List<MapEntry<String, String>> getSupportedLanguages() {
    return languageNames.entries.toList();
  }
}

/// Extension on Locale to provide utility methods
extension LocaleExtension on Locale {
  bool get isArabic => languageCode == 'ar';
  bool get isEnglish => languageCode == 'en';
}

/// Get instance of localization service
LocalizationService getLocalizationService() {
  return Get.find<LocalizationService>();
}
