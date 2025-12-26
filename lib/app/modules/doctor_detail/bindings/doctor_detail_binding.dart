import 'package:get/get.dart';
import '../controllers/doctor_detail_controller.dart';
import 'package:pharma_connect/app/modules/consultations/services/doctors_repository.dart';

// Doctor detail binding for dependency injection
class DoctorDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy load repositories
    Get.lazyPut<DoctorsRepository>(() => DoctorsRepository());

    // Lazy load DoctorDetailController - only created when first accessed
    Get.lazyPut<DoctorDetailController>(() => DoctorDetailController());
  }
}
