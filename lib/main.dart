import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pharma_connect/app/core/network/api_client.dart';
import 'package:pharma_connect/app/core/services/notification_service.dart';
import 'package:pharma_connect/app/modules/auth/services/auth_service.dart';
import 'package:pharma_connect/app/modules/navigation/bindings/navigation_binding.dart';
import 'package:pharma_connect/app/modules/navigation/services/navigation_service.dart';
import 'package:pharma_connect/app/core/services/localization_service.dart';
import 'package:pharma_connect/app/core/services/settings_service.dart';
import 'package:pharma_connect/app/core/services/storage_service.dart';
import 'package:pharma_connect/app/core/services/theme_service.dart';
import 'package:pharma_connect/app/locales/translations.dart';
import 'app/routes/app_routes.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/app_theme.dart';
import 'firebase_options.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  log('Firebase initialized');

  // Initialize GetStorage first - required before using GetStorage anywhere
  await GetStorage.init();
  ApiClient().init();
  log('GetStorage initialized');

  // Initialize storage service first (before AuthService)
  await Get.putAsync<StorageService>(() async {
    final service = await StorageService().init();
    log('StorageService initialized');
    return service;
  });

  // Initialize NotificationService to get FCM token
  await Get.putAsync<NotificationService>(() async {
    final service = await NotificationService().init();
    log('NotificationService initialized');
    return service;
  });

  // Initialize settings service first (before LocalizationService and ThemeService)
  await Get.putAsync<SettingsService>(() async {
    final service = SettingsService();
    log(
      'SettingsService initialized with settings: ${service.getAllSettings()}',
    );
    await Future.delayed(const Duration(milliseconds: 100));
    return service;
  });

  // Initialize localization service with saved language
  await Get.putAsync<LocalizationService>(() async {
    final service = LocalizationService();
    service.onInit();
    // Set the saved language from settings
    final settingsService = Get.find<SettingsService>();
    service.setLanguage(settingsService.currentLanguage);
    return service;
  });

  // Initialize theme service (depends on settings service)
  await Get.putAsync<ThemeService>(() async {
    final service = ThemeService();
    log('ThemeService initialized - Dark mode: ${service.isDarkMode}');
    await Future.delayed(const Duration(milliseconds: 100));
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
    final settingsService = Get.find<SettingsService>();
    final themeService = Get.find<ThemeService>();
    final authService = Get.find<AuthService>();

    return Obx(
      () => GetMaterialApp(
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
        themeMode: themeService.isDarkModeRx.value
            ? ThemeMode.dark
            : ThemeMode.light,
        // Set initial route based on authentication status
        initialRoute: authService.isAuthenticated
            ? AppRoutes.home
            : AppRoutes.login,
        getPages: AppPages.pages,
        defaultTransition: Transition.cupertino,

        // Localization Configuration
        translations: AppTranslations(),
        locale: Locale(settingsService.currentLanguageRx.value),
        fallbackLocale: const Locale('en'),
        supportedLocales: LocalizationService.supportedLocales,
      ),
    );
  }
}
