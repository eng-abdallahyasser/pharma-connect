import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/services/localization_service.dart';
import '../../../theme/app_colors.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();

    return Obx(() {
      final isArabic = localizationService.isArabic();
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => localizationService.toggleLanguage(),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(AppColors.border)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.language,
                  size: 20,
                  color: Color(AppColors.textSecondary),
                ),
                const SizedBox(width: 8),
                Text(
                  isArabic ? 'English' : 'العربية',
                  style: const TextStyle(
                    color: Color(AppColors.textPrimary),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
