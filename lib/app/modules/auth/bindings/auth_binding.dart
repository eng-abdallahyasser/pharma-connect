import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../services/auth_service.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Register AuthService as a singleton
    Get.put<AuthService>(AuthService());

    // Register AuthController
    Get.put<AuthController>(AuthController());
  }
}
