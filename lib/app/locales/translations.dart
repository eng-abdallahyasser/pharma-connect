import 'package:get/get.dart';
import 'en_us.dart';
import 'ar_ar.dart';

/// Translation helper class to manage all translations
///
/// This class provides:
/// - Centralized translation maps
/// - Language switching
/// - Translation retrieval by key
class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'en_US': enUS, 'ar_AR': arAR};
}

/// Extension on String to easily translate text
/// Usage: 'profile.title'.tr
extension TranslationExtension on String {
  String get translate => tr;
}

/// Get translation by key
/// Usage: getTranslation('profile.title')
String getTranslation(String key) {
  final currentLang = Get.locale?.languageCode ?? 'en';
  final translations = currentLang == 'ar' ? arAR : enUS;
  return translations[key] ?? key;
}
