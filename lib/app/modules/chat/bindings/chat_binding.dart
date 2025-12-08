import 'package:get/get.dart';
import '../controllers/chat_controller.dart';

// Chat binding for dependency injection
class ChatBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy load ChatController - only created when first accessed
    Get.lazyPut<ChatController>(
      () => ChatController(),
    );
  }
}
