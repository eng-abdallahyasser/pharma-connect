import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../widgets/profile_header.dart';
import '../widgets/menu_item_card.dart';
import '../widgets/settings_item_card.dart';
import '../widgets/medical_profile_modal.dart';
import '../widgets/prescriptions_modal.dart';
import '../widgets/family_members_modal.dart';

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
            ProfileHeader(
              user: controller.currentUser,
              onEditPressed: () {
                // TODO: Navigate to edit profile screen
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
                        color: Colors.grey[600],
                      ),
                    ),
                  ),

                  // Account menu items container
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(13),
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
                        color: Colors.grey[600],
                      ),
                    ),
                  ),

                  // Settings menu items container
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(13),
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
                        backgroundColor: const Color(0xFFEF4444),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.logout,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.white,
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
                    child: Text(
                      'Version 1.0.0',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),

      // Medical Profile Modal
      floatingActionButton: Obx(
        () => controller.showMedicalProfile.value
            ? Stack(
                children: [
                  // Backdrop
                  GestureDetector(
                    onTap: controller.toggleMedicalProfile,
                    child: Container(color: Colors.black.withAlpha(13)),
                  ),
                  // Modal
                  Center(
                    child: MedicalProfileModal(
                      user: controller.currentUser,
                      onClose: controller.toggleMedicalProfile,
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Additional modals using GetX dialog
      bottomSheet: Obx(() {
        // Prescriptions modal
        if (controller.showPrescriptions.value) {
          return PrescriptionsModal(
            prescriptions: controller.getAllPrescriptions(),
            onClose: controller.togglePrescriptions,
            onDownload: (prescription) {
              controller.downloadPrescription(prescription);
            },
          );
        }

        // Family members modal
        if (controller.showFamilyMembers.value) {
          return FamilyMembersModal(
            familyMembers: controller.getAllFamilyMembers(),
            onClose: controller.toggleFamilyMembers,
            onAddPressed: () {
              // TODO: Navigate to add family member screen
            },
          );
        }

        return const SizedBox.shrink();
      }),
    );
  }
}
