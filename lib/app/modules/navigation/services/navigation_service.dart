import 'package:get/get.dart';
import '../controllers/navigation_controller.dart';

/// Navigation Service for centralized navigation logic
/// Follows GetX best practices for navigation management
class NavigationService {
  static final NavigationService _instance = NavigationService._internal();

  factory NavigationService() {
    return _instance;
  }

  NavigationService._internal();

  late NavigationController _navigationController;

  /// Initialize the navigation service
  /// Call this in main.dart or app initialization
  void initialize() {
    _navigationController = Get.find<NavigationController>();
  }

  /// Navigate to home tab
  void goHome() {
    _navigationController.navigateToId('home');
  }

  /// Navigate to pharmacies tab
  void goPharmacies() {
    _navigationController.navigateToId('pharmacies');
  }

  /// Navigate to consultations tab
  void goConsultations() {
    _navigationController.navigateToId('consultations');
  }

  /// Navigate to profile tab
  void goProfile() {
    _navigationController.navigateToId('profile');
  }

  /// Navigate to a specific route
  void goToRoute(String route) {
    _navigationController.navigateToRoute(route);
  }

  /// Navigate by tab index
  void goToIndex(int index) {
    _navigationController.navigateToIndex(index);
  }

  /// Navigate to pharmacy detail (overlay)
  void goToPharmacyDetail(dynamic pharmacy) {
    Get.toNamed('/pharmacy-detail', arguments: pharmacy);
  }

  /// Navigate to chat (overlay)
  void goToChat(dynamic doctor) {
    Get.toNamed('/chat', arguments: doctor);
  }

  /// Navigate to medicines (overlay)
  void goToMedicines() {
    Get.toNamed('/medicines');
  }

  /// Navigate to notifications (overlay)
  void goToNotifications() {
    Get.toNamed('/notifications');
  }

  /// Get current active tab
  String? getCurrentTab() {
    return _navigationController.currentNavItem?.id;
  }

  /// Check if specific tab is active
  bool isTabActive(String tabId) {
    return _navigationController.isTabActive(tabId);
  }

  /// Get current tab index
  int getCurrentIndex() {
    return _navigationController.currentIndex.value;
  }

  /// Update current index (internal state only, no navigation)
  void updateCurrentIndex(int index) {
    _navigationController.updateCurrentIndex(index);
  }
}
