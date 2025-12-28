import 'package:get/get.dart';
import '../controllers/pharmacy_request_controller.dart';

class PharmacyRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PharmacyRequestController>(() => PharmacyRequestController());
  }
}
