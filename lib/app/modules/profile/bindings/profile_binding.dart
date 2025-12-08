import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

// Profile binding for dependency injection
class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy load ProfileController - only created when first accessed
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
