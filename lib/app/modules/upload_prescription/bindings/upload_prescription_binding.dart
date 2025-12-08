import 'package:get/get.dart';
import '../controllers/upload_prescription_controller.dart';

// Upload prescription binding for dependency injection
class UploadPrescriptionBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy load UploadPrescriptionController - only created when first accessed
    Get.lazyPut<UploadPrescriptionController>(
      () => UploadPrescriptionController(),
    );
  }
}
