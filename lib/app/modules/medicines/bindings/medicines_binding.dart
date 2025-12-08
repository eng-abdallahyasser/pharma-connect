import 'package:get/get.dart';
import '../controllers/medicines_controller.dart';

// Medicines binding for dependency injection
class MedicinesBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy load MedicinesController - only created when first accessed
    Get.lazyPut<MedicinesController>(
      () => MedicinesController(),
    );
  }
}
