import 'package:get/get.dart';
import '../controllers/notifications_controller.dart';

// Notifications binding for dependency injection
class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy load NotificationsController - only created when first accessed
    Get.lazyPut<NotificationsController>(
      () => NotificationsController(),
    );
  }
}
