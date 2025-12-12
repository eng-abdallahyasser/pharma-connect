import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/nav_item_model.dart';

class NavigationController extends GetxController {
  // Observable properties
  final currentIndex = 0.obs;
  final navItems = <NavItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeNavItems();
  }

  void _initializeNavItems() {
    navItems.assignAll([
      NavItemModel(
        id: 'home',
        label: 'nav.home',
        icon: Icons.home,
        route: '/home',
      ),
      NavItemModel(
        id: 'pharmacies',
        label: 'nav.pharmacies',
        icon: Icons.store,
        route: '/pharmacies',
      ),
      NavItemModel(
        id: 'consultations',
        label: 'nav.consultations',
        icon: Icons.medical_services,
        route: '/consultations',
      ),
      NavItemModel(
        id: 'profile',
        label: 'nav.profile',
        icon: Icons.person,
        route: '/profile',
      ),
    ]);
  }

  /// Navigate to a specific tab by index
  void navigateToIndex(int index) {
    if (index >= 0 && index < navItems.length) {
      currentIndex.value = index;
      Get.offNamed(navItems[index].route);
    }
  }

  /// Navigate to a specific tab by route
  void navigateToRoute(String route) {
    final index = navItems.indexWhere((item) => item.route == route);
    if (index != -1) {
      currentIndex.value = index;
      Get.offNamed(route);
    }
  }

  /// Navigate to a specific tab by ID
  void navigateToId(String id) {
    final index = navItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      currentIndex.value = index;
      Get.offNamed(navItems[index].route);
    }
  }

  /// Update current index without navigation (for internal state)
  void updateCurrentIndex(int index) {
    if (index >= 0 && index < navItems.length) {
      currentIndex.value = index;
    }
  }

  /// Get current navigation item
  NavItemModel? get currentNavItem {
    if (currentIndex.value >= 0 && currentIndex.value < navItems.length) {
      return navItems[currentIndex.value];
    }
    return null;
  }

  /// Check if a specific tab is active
  bool isTabActive(String id) {
    return currentNavItem?.id == id;
  }

  /// Get navigation item by ID
  NavItemModel? getNavItemById(String id) {
    try {
      return navItems.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get navigation item by route
  NavItemModel? getNavItemByRoute(String route) {
    try {
      return navItems.firstWhere((item) => item.route == route);
    } catch (e) {
      return null;
    }
  }
}
