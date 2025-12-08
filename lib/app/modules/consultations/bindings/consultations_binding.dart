import 'package:get/get.dart';
import '../controllers/consultations_controller.dart';

// Consultations binding for dependency injection
class ConsultationsBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy load ConsultationsController - only created when first accessed
    Get.lazyPut<ConsultationsController>(
      () => ConsultationsController(),
    );
  }
}
