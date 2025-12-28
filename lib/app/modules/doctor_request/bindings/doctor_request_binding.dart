import 'package:get/get.dart';
import '../controllers/doctor_request_controller.dart';

class DoctorRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorRequestController>(() => DoctorRequestController());
  }
}
