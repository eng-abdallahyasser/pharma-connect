import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_connect/app/locales/translations.dart';
import 'package:pharma_connect/app/services/localization_service.dart';
import '../models/user_model.dart';
import '../models/prescription_model.dart';
import '../models/family_member_model.dart';
import '../models/menu_item_model.dart';

// Profile controller manages user profile data and state
class ProfileController extends GetxController {
  // Observable properties for reactive UI updates
  final showMedicalProfile = false.obs;
  final showPrescriptions = false.obs;
  final showFamilyMembers = false.obs;
  final notificationsEnabled = true.obs;
  final darkModeEnabled = false.obs;

  // User data
  late UserModel currentUser;
  late List<PrescriptionModel> prescriptions;
  late List<FamilyMemberModel> familyMembers;
  late List<MenuItemModel> menuItems;
  late List<SettingsItemModel> settingsItems;

  @override
  void onInit() {
    super.onInit();
    // Initialize all data when controller is created
    _initializeUserData();
    _initializePrescriptions();
    _initializeFamilyMembers();
    _initializeMenuItems();
    _initializeSettingsItems();
  }

  // Initialize current user data with sample information
  void _initializeUserData() {
    currentUser = UserModel(
      id: 1,
      name: 'John Doe',
      email: 'john.doe@email.com',
      phone: '+1 234 567 8900',
      imageUrl:
          'https://images.unsplash.com/photo-1659353888906-adb3e0041693?w=200',
      bloodType: 'O+',
      allergies: ['Penicillin', 'Peanuts', 'Shellfish'],
      chronicConditions: ['Hypertension', 'Type 2 Diabetes'],
      insuranceProvider: 'HealthCare Plus',
      insuranceNumber: 'HC123456789',
      emergencyContact: EmergencyContact(
        name: 'Jane Doe',
        relation: 'Spouse',
        phone: '+1 234 567 8901',
      ),
    );
  }

  // Initialize prescription history with sample data
  void _initializePrescriptions() {
    prescriptions = [
      PrescriptionModel(
        id: 1,
        doctorName: 'Dr. Sarah Johnson',
        date: 'Dec 3, 2024',
        diagnosis: 'Acute Bronchitis',
        medicines: ['Amoxicillin 500mg', 'Cough Syrup'],
        status: 'Active',
      ),
      PrescriptionModel(
        id: 2,
        doctorName: 'Dr. Michael Chen',
        date: 'Nov 20, 2024',
        diagnosis: 'Vitamin D Deficiency',
        medicines: ['Vitamin D3 1000 IU'],
        status: 'Active',
      ),
      PrescriptionModel(
        id: 3,
        doctorName: 'Dr. Emily Roberts',
        date: 'Oct 15, 2024',
        diagnosis: 'Seasonal Allergies',
        medicines: ['Cetirizine 10mg', 'Nasal Spray'],
        status: 'Completed',
      ),
    ];
  }

  // Initialize family members with sample data
  void _initializeFamilyMembers() {
    familyMembers = [
      FamilyMemberModel(
        id: 1,
        name: 'Sarah Johnson',
        relation: 'Mother',
        age: 58,
        bloodType: 'A+',
        imageUrl:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200',
        conditions: ['Hypertension'],
      ),
      FamilyMemberModel(
        id: 2,
        name: 'Emma Johnson',
        relation: 'Daughter',
        age: 12,
        bloodType: 'O+',
        imageUrl:
            'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200',
        conditions: [],
      ),
      FamilyMemberModel(
        id: 3,
        name: 'Robert Johnson',
        relation: 'Father',
        age: 62,
        bloodType: 'B+',
        imageUrl:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
        conditions: ['Type 2 Diabetes', 'High Cholesterol'],
      ),
    ];
  }

  // Initialize menu items with callbacks
  void _initializeMenuItems() {
    menuItems = [
      MenuItemModel(
        id: 'personal',
        label: getTranslation('profile.edit_profile'),
        description: getTranslation('profile.view_profile'),
        icon: Icons.person,
        iconColor: const Color(0xFF1A73E8),
        onTap: () {
          // TODO: Navigate to edit profile
        },
      ),
      MenuItemModel(
        id: 'medical',
        label: getTranslation('profile.medical_profile'),
        description: getTranslation('profile.medical_profile_desc'),
        icon: Icons.favorite,
        iconColor: const Color(0xFFEF4444),
        onTap: () => showMedicalProfile.value = true,
      ),
      MenuItemModel(
        id: 'family',
        label: getTranslation('profile.family_members'),
        description: getTranslation('profile.family_members_desc'),
        icon: Icons.people,
        iconColor: const Color(0xFF22C55E),
        badge: familyMembers.length,
        onTap: () => showFamilyMembers.value = true,
      ),
      MenuItemModel(
        id: 'prescriptions',
        label: getTranslation('profile.prescriptions'),
        description: getTranslation('profile.prescriptions_desc'),
        icon: Icons.description,
        iconColor: const Color(0xFFA855F7),
        badge: prescriptions.where((p) => p.isActive).length,
        onTap: () => showPrescriptions.value = true,
      ),
      MenuItemModel(
        id: 'addresses',
        label: getTranslation('profile.saved_addresses'),
        description: getTranslation('profile.saved_addresses_desc'),
        icon: Icons.location_on,
        iconColor: const Color(0xFFF97316),
        onTap: () {
          // TODO: Navigate to addresses
        },
      ),
      MenuItemModel(
        id: 'orders',
        label: getTranslation('profile.order_history'),
        description: getTranslation('profile.order_history_desc'),
        icon: Icons.shopping_bag,
        iconColor: const Color(0xFFEC4899),
        onTap: () {
          // TODO: Navigate to order history
        },
      ),
    ];
  }

  // Initialize settings items with callbacks
  void _initializeSettingsItems() {
    final localizationService = Get.find<LocalizationService>();

    settingsItems = [
      SettingsItemModel(
        id: 'notifications',
        label: getTranslation('profile.notifications'),
        icon: Icons.notifications,
        hasToggle: true,
        onTap: () => notificationsEnabled.toggle(),
      ),
      SettingsItemModel(
        id: 'darkmode',
        label: getTranslation('profile.dark_mode'),
        icon: Icons.dark_mode,
        hasToggle: true,
        onTap: () => darkModeEnabled.toggle(),
      ),
      SettingsItemModel(
        id: 'language',
        label: getTranslation('profile.language'),
        icon: Icons.language,
        value: localizationService.getCurrentLanguageName(),
        onTap: () {
          // Show language selection dialog
          Get.dialog(
            AlertDialog(
              title: Text(getTranslation('language.title')),
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: localizationService.getSupportedLanguages().map((
                    lang,
                  ) {
                    return Obx(() {
                      final isSelected =
                          localizationService.currentLanguage.value == lang.key;
                      return GestureDetector(
                        onTap: () {
                          localizationService.setLanguage(lang.key);
                          _updateLanguageInSettings();
                          Get.back();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.blue.withOpacity(0.1)
                                : Colors.transparent,
                            border: Border(
                              bottom: BorderSide(color: Colors.grey.shade200),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  lang.value,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: isSelected
                                        ? Colors.blue
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                const Icon(Icons.check, color: Colors.blue),
                            ],
                          ),
                        ),
                      );
                    });
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text(getTranslation('common.cancel')),
                ),
              ],
            ),
          );
        },
      ),
      SettingsItemModel(
        id: 'privacy',
        label: getTranslation('profile.privacy_security'),
        icon: Icons.security,
        onTap: () {
          // TODO: Navigate to privacy settings
        },
      ),
    ];
  }

  // Update language value in settings items after language change
  void _updateLanguageInSettings() {
    final languageItem = settingsItems.firstWhereOrNull(
      (item) => item.id == 'language',
    );
    if (languageItem != null) {
      // Re-initialize settings items to update all text
      _initializeSettingsItems();
    }
  }

  // Toggle medical profile modal visibility
  void toggleMedicalProfile() {
    showMedicalProfile.toggle();
  }

  // Toggle prescriptions modal visibility
  void togglePrescriptions() {
    showPrescriptions.toggle();
  }

  // Toggle family members modal visibility
  void toggleFamilyMembers() {
    showFamilyMembers.toggle();
  }

  // Handle logout action
  void logout() {
    // TODO: Implement actual logout logic
    // - Clear user data
    // - Clear authentication tokens
    // - Navigate to login screen
    Get.offNamed('/login');
  }

  // Get count of active prescriptions
  int getActivePrescriptionCount() {
    return prescriptions.where((p) => p.isActive).length;
  }

  // Get all prescriptions (for modal display)
  List<PrescriptionModel> getAllPrescriptions() {
    return prescriptions;
  }

  // Get all family members (for modal display)
  List<FamilyMemberModel> getAllFamilyMembers() {
    return familyMembers;
  }

  // Update user profile (placeholder for API call)
  Future<void> updateUserProfile(UserModel updatedUser) async {
    try {
      // TODO: Make API call to update user profile
      currentUser = updatedUser;
      Get.snackbar('Success', 'Profile updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile: $e');
    }
  }

  // Download prescription (placeholder for file download)
  Future<void> downloadPrescription(PrescriptionModel prescription) async {
    try {
      // TODO: Implement prescription download logic
      Get.snackbar('Success', 'Prescription downloaded');
    } catch (e) {
      Get.snackbar('Error', 'Failed to download prescription: $e');
    }
  }

  // Add family member (placeholder for API call)
  Future<void> addFamilyMember(FamilyMemberModel member) async {
    try {
      // TODO: Make API call to add family member
      familyMembers.add(member);
      Get.snackbar('Success', 'Family member added');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add family member: $e');
    }
  }
}
