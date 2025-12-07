import 'package:get/get.dart';

class HomeController extends GetxController {
  // Observables
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize your controller here
  }

  @override
  void onReady() {
    super.onReady();
    // Called after the widget is rendered on screen
  }

  @override
  void onClose() {
    super.onClose();
    // Dispose resources
  }

  void increment() => count.value++;
  void decrement() => count.value--;
  void reset() => count.value = 0;
}
