import 'package:get/get.dart';
import '../controllers/navigation_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    // Register NavigationController as a singleton
    // This ensures the same instance is used throughout the app
    Get.put<NavigationController>(
      NavigationController(),
      permanent: true, // Keep in memory even when not in use
    );
  }
}
