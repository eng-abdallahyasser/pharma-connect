import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:pharma_connect/app/modules/navigation/bindings/navigation_binding.dart';
import 'package:pharma_connect/app/modules/navigation/services/navigation_service.dart';
import 'package:pharma_connect/app/services/localization_service.dart';
import 'package:pharma_connect/app/locales/translations.dart';
import 'app/routes/app_routes.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/app_theme.dart';

void main() async {
  // Initialize localization service first
  await Get.putAsync<LocalizationService>(() async {
    final service = LocalizationService();
    service.onInit();
    return service;
  });

  // Initialize navigation binding before app starts
  NavigationBinding().dependencies();

  // Initialize navigation service
  NavigationService().initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // 1. Register the Global Delegates
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      debugShowCheckedModeBanner: false,
      title: 'Healthcare App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: AppRoutes.home,
      getPages: AppPages.pages,
      defaultTransition: Transition.cupertino,

      // Localization Configuration
      translations: AppTranslations(),
      locale: const Locale('en'), // Default locale
      fallbackLocale: const Locale('en'), // Fallback locale
      supportedLocales: LocalizationService.supportedLocales,
    );
  }
}
