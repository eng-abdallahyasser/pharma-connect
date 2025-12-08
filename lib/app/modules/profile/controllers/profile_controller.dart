import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        label: 'Personal Information',
        description: 'Update your details',
        icon: Icons.person,
        iconColor: const Color(0xFF1A73E8),
        onTap: () {
          // TODO: Navigate to edit profile
        },
      ),
      MenuItemModel(
        id: 'medical',
        label: 'Medical Profile',
        description: 'Allergies & conditions',
        icon: Icons.favorite,
        iconColor: const Color(0xFFEF4444),
        onTap: () => showMedicalProfile.value = true,
      ),
      MenuItemModel(
        id: 'family',
        label: 'Family Members',
        description: 'Manage family profiles',
        icon: Icons.people,
        iconColor: const Color(0xFF22C55E),
        badge: familyMembers.length,
        onTap: () => showFamilyMembers.value = true,
      ),
      MenuItemModel(
        id: 'prescriptions',
        label: 'Prescription History',
        description: 'View past prescriptions',
        icon: Icons.description,
        iconColor: const Color(0xFFA855F7),
        badge: prescriptions.where((p) => p.isActive).length,
        onTap: () => showPrescriptions.value = true,
      ),
      MenuItemModel(
        id: 'addresses',
        label: 'Saved Addresses',
        description: 'Manage delivery locations',
        icon: Icons.location_on,
        iconColor: const Color(0xFFF97316),
        onTap: () {
          // TODO: Navigate to addresses
        },
      ),
      MenuItemModel(
        id: 'orders',
        label: 'Order History',
        description: 'View past orders',
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
    settingsItems = [
      SettingsItemModel(
        id: 'notifications',
        label: 'Notifications',
        icon: Icons.notifications,
        hasToggle: true,
        onTap: () => notificationsEnabled.toggle(),
      ),
      SettingsItemModel(
        id: 'darkmode',
        label: 'Dark Mode',
        icon: Icons.dark_mode,
        hasToggle: true,
        onTap: () => darkModeEnabled.toggle(),
      ),
      SettingsItemModel(
        id: 'language',
        label: 'Language',
        icon: Icons.language,
        value: 'English',
        onTap: () {
          // TODO: Navigate to language selection
        },
      ),
      SettingsItemModel(
        id: 'privacy',
        label: 'Privacy & Security',
        icon: Icons.security,
        onTap: () {
          // TODO: Navigate to privacy settings
        },
      ),
    ];
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
