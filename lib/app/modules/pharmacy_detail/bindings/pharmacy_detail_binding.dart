import 'package:get/get.dart';
import '../controllers/pharmacy_detail_controller.dart';

class PharmacyDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PharmacyDetailController>(() => PharmacyDetailController());
  }
}
