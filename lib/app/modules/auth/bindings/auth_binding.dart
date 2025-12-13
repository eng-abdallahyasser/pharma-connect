import 'package:get/get.dart';
import 'package:pharma_connect/app/core/services/storage_service.dart';
import '../controllers/auth_controller.dart';
import '../services/auth_service.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Register AuthService as a singleton
    Get.put<AuthService>(AuthService());

    // Register StorageService as a singleton
    Get.put<StorageService>(StorageService());

    // Register AuthController
    Get.put<AuthController>(AuthController());
  }
}
