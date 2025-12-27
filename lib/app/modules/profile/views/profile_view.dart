import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../widgets/profile_header.dart';
import '../widgets/menu_item_card.dart';
import '../widgets/settings_item_card.dart';

// Profile view - main screen for user profile management
class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header with user information
            // Profile header with user information
            GetBuilder<ProfileController>(
              builder: (controller) {
                return ProfileHeader(
                  user: controller.currentUser,
                  onEditPressed: () {
                  },
                  onPhotoEditPressed: controller.updateProfilePhoto,
                );
              },
            ),

            // Main content area with padding
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Account section title
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      'Account',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),

                  // Account menu items container
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).shadowColor.withAlpha(13),
                          blurRadius: 4,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: List.generate(
                        controller.menuItems.length,
                        (index) => MenuItemCard(
                          item: controller.menuItems[index],
                          isLast: index == controller.menuItems.length - 1,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Settings section title
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),

                  // Settings menu items container
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).shadowColor.withAlpha(13),
                          blurRadius: 4,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: List.generate(
                        controller.settingsItems.length,
                        (index) => SettingsItemCard(
                          item: controller.settingsItems[index],
                          isLast: index == controller.settingsItems.length - 1,
                          darkModeEnabled: controller.darkModeEnabled,
                          notificationsEnabled: controller.notificationsEnabled,
                          onToggleChanged: (value) {
                            // Handle toggle changes if needed
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Logout button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.logout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.error,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout,
                            color: Theme.of(context).colorScheme.onError,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Logout',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onError,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // App version text
                  Center(
                    child: Obx(
                      () => Text(
                        'Version ${controller.version.value}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
