import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_connect/app/modules/navigation/bindings/navigation_binding.dart';
import 'package:pharma_connect/app/modules/navigation/services/navigation_service.dart';
import 'app/routes/app_routes.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/app_theme.dart';


void main() {
  // Initialize navigation binding before app starts
  NavigationBinding().dependencies();

  // Initialize navigation service
  NavigationService().initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Healthcare App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: AppRoutes.home,
      getPages: AppPages.pages,
      defaultTransition: Transition.cupertino,
    );
  }
}
