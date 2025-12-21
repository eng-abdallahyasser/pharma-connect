import 'package:get/get.dart';
import 'package:pharma_connect/app/data/providers/pharmacies_provider.dart';
import '../controllers/pharmacies_controller.dart';

class PharmaciesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PharmaciesProvider>(() => PharmaciesProvider());
    Get.lazyPut<PharmaciesController>(() => PharmaciesController());
  }
}
