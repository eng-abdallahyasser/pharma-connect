import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_connect/app/services/localization_service.dart';
import 'package:pharma_connect/app/locales/translations.dart';

/// Language Selection Widget
///
/// This widget displays a dialog for users to select their preferred language.
/// It shows available languages and updates the app locale on selection.
class LanguageSelectionDialog extends StatelessWidget {
  final LocalizationService localizationService =
      Get.find<LocalizationService>();

  LanguageSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(getTranslation('language.title')),
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: localizationService.getSupportedLanguages().map((lang) {
            return Obx(() {
              final isSelected =
                  localizationService.currentLanguage.value == lang.key;
              return GestureDetector(
                onTap: () {
                  localizationService.setLanguage(lang.key);
                  Get.back();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.blue.withOpacity(0.1)
                        : Colors.transparent,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          lang.value,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected ? Colors.blue : Colors.black87,
                          ),
                        ),
                      ),
                      if (isSelected)
                        const Icon(Icons.check, color: Colors.blue),
                    ],
                  ),
                ),
              );
            });
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text(getTranslation('common.cancel')),
        ),
      ],
    );
  }
}

/// Language Selection Widget for use in settings
///
/// This is a more compact version suitable for use in settings lists
class LanguageSelectionTile extends StatelessWidget {
  final LocalizationService localizationService =
      Get.find<LocalizationService>();
  final VoidCallback? onLanguageChanged;

  LanguageSelectionTile({super.key, this.onLanguageChanged});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => LanguageSelectionDialog(),
          );
          onLanguageChanged?.call();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
          ),
          child: Row(
            children: [
              const Icon(Icons.language, color: Colors.blue),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getTranslation('profile.language'),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                localizationService.getCurrentLanguageName(),
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      );
    });
  }
}

/// Show Language Selection Dialog
///
/// This function displays a language selection dialog
void showLanguageSelectionDialog() {
  Get.dialog(LanguageSelectionDialog(), barrierDismissible: false);
}

/// Language Controller for managing language state
///
/// This controller can be used to manage language-related state and logic
class LanguageController extends GetxController {
  final localizationService = Get.find<LocalizationService>();

  // Observable for current language
  late Rx<String> currentLanguage;

  @override
  void onInit() {
    super.onInit();
    currentLanguage = localizationService.currentLanguage;
  }

  /// Change language
  void changeLanguage(String languageCode) {
    localizationService.setLanguage(languageCode);
  }

  /// Toggle between English and Arabic
  void toggleLanguage() {
    localizationService.toggleLanguage();
  }

  /// Get list of supported languages
  List<MapEntry<String, String>> getSupportedLanguages() {
    return localizationService.getSupportedLanguages();
  }
}
