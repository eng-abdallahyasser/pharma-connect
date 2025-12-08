import 'package:get/get.dart';
import '../controllers/pharmacy_detail_controller.dart';

// Pharmacy detail binding for dependency injection
class PharmacyDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy load PharmacyDetailController - only created when first accessed
    Get.lazyPut<PharmacyDetailController>(
      () => PharmacyDetailController(),
    );
  }
}
