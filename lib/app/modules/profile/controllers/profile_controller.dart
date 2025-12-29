import 'dart:io';
import 'dart:developer';
import 'package:pharma_connect/app/core/network/api_exceptions.dart';
import 'package:pharma_connect/app/core/services/storage_service.dart';
import 'package:pharma_connect/app/modules/home/widgets/addresses_bottom_sheet.dart';

import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:pharma_connect/app/core/network/api_client.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pharma_connect/app/core/network/api_constants.dart';
import 'package:pharma_connect/app/locales/translations.dart';
import 'package:pharma_connect/app/core/services/localization_service.dart';
import 'package:pharma_connect/app/core/services/theme_service.dart';
import 'package:pharma_connect/app/core/services/settings_service.dart';
import 'package:pharma_connect/app/modules/auth/services/auth_service.dart';
import 'package:pharma_connect/app/modules/profile/widgets/edit_profile_modal.dart';
import 'package:pharma_connect/app/modules/profile/widgets/family_members_modal.dart';
import 'package:pharma_connect/app/modules/profile/widgets/medical_profile_modal.dart';
import 'package:pharma_connect/app/modules/profile/widgets/prescriptions_modal.dart';
import 'package:pharma_connect/app/modules/profile/widgets/add_edit_family_member_modal.dart';
import '../models/user_model.dart';
import '../models/prescription_model.dart';
import '../models/family_member_model.dart';
import '../models/menu_item_model.dart';
import '../models/medical_profile_model.dart';
import '../services/profile_repository.dart';

// Profile controller manages user profile data and state
class ProfileController extends GetxController {
  // Observable properties for reactive UI updates
  final showMedicalProfile = false.obs;
  final showPrescriptions = false.obs;
  final showFamilyMembers = false.obs;
  final version = "1.0.0".obs;

  // Services
  late SettingsService _settingsService;
  late ThemeService _themeService;

  // Use settings service observables for notifications and dark mode
  late RxBool notificationsEnabled;
  late RxBool darkModeEnabled;

  // Repositories
  final ProfileRepository _profileRepository = ProfileRepository();

  // Medical Profile
  final Rx<MedicalProfile?> medicalProfile = Rx<MedicalProfile?>(null);
  final RxBool isLoadingMedicalProfile = false.obs;

  // User data
  late UserModel currentUser;
  late List<PrescriptionModel> prescriptions;

  // Family Members
  RxList<FamilyMemberModel> familyMembers = <FamilyMemberModel>[].obs;
  final RxBool isLoadingFamilyMembers = false.obs;

  // Menu items
  late List<MenuItemModel> menuItems;
  late List<SettingsItemModel> settingsItems;
  final screenHeight = MediaQuery.of(Get.context!).size.height;

  @override
  void onInit() {
    super.onInit();
    // Get service instances
    _settingsService = Get.find<SettingsService>();
    _themeService = Get.find<ThemeService>();

    // Bind observables to settings service
    notificationsEnabled = _settingsService.notificationsEnabledRx;
    darkModeEnabled = _themeService.isDarkModeRx;

    // Initialize all data when controller is created
    _loadCurrentUser();
    _initializePrescriptions();
    _initializeFamilyMembers();
    _initializeMenuItems();
    _initializeSettingsItems();
    _getAppVersion();
  }

  Future<void> _getAppVersion() async {
    try {
      // Await the Future to get PackageInfo
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      log('Package info: $packageInfo');
      version.value = packageInfo.version; // Now you can access .version
    } catch (e) {
      version.value = 'Unknown';
      log('Error getting package info: $e');
    }
  }

  // Initialize current user data with sample information
  void _loadCurrentUser() {
    try {
      // Safe way using null-aware operator
      final user = Get.find<StorageService>().getUser();

      // Or with null check
      if (user != null) {
        log('User profile image: ${user.profileImage}');
        currentUser = UserModel(
          id: 124545,
          name: user.fullName,
          email: user.email,
          phone: user.phoneNumber,
          imageUrl: user.profileImage ?? "",
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
      } else {
        currentUser = UserModel(
          id: 124545,
          name: 'John Doe',
          email: 'john.doe@example.com',
          phone: '+1 234 567 8901',
          imageUrl:
              'https://images.unsplash.com/photo-1506794778202-cad84cf45f1a?w=200',
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
    } catch (e) {
      log('Error loading current user: $e');
    }
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
          Get.bottomSheet(
            SizedBox(
              height: screenHeight * 0.85,
              child: EditProfileModal(
                user: currentUser,
                notificationsEnabled: notificationsEnabled.value,
                onSave: (data) => updateUserProfile(data),
              ),
            ),
            isScrollControlled: true,
            enableDrag: true,
          );
        },
      ),
      MenuItemModel(
        id: 'medical',
        label: getTranslation('profile.medical_profile'),
        description: getTranslation('profile.medical_profile_desc'),
        icon: Icons.favorite,
        iconColor: const Color(0xFFEF4444),
        onTap: () {
          fetchMedicalProfile();
          Get.bottomSheet(
            SizedBox(
              height: screenHeight * 0.85,
              child: Obx(
                () => MedicalProfileModal(
                  user: currentUser,
                  medicalProfile: medicalProfile.value,
                  isLoading: isLoadingMedicalProfile.value,
                  onClose: Get.back,
                ),
              ),
            ),
            isScrollControlled: true,
            enableDrag: true,
          );
        },
      ),
      MenuItemModel(
        id: 'family',
        label: getTranslation('profile.family_members'),
        description: getTranslation('profile.family_members_desc'),
        icon: Icons.people,
        iconColor: const Color(0xFF22C55E),
        badge: familyMembers.length,
        onTap: () {
          Get.bottomSheet(
            Obx(() {
              return SizedBox(
                height: screenHeight * 0.85,
                child: FamilyMembersModal(
                  familyMembers: familyMembers,
                  isLoading: isLoadingFamilyMembers.value,
                  onClose: Get.back,
                  onAddPressed: () {
                    Get.bottomSheet(
                      const AddEditFamilyMemberModal(),
                      isScrollControlled: true,
                    );
                  },
                  onEditPressed: (member) {
                    Get.bottomSheet(
                      AddEditFamilyMemberModal(member: member),
                      isScrollControlled: true,
                    );
                  },
                  onDeletePressed: (member) {
                    Get.defaultDialog(
                      title: 'Confirm Delete',
                      middleText:
                          'Are you sure you want to delete ${member.displayName}?',
                      textConfirm: 'Delete',
                      textCancel: 'Cancel',
                      confirmTextColor: Colors.white,
                      onConfirm: () {
                        Get.back(); // Close dialog
                        deleteFamilyMember(member.id!);
                      },
                    );
                  },
                ),
              );
            }),
            isScrollControlled: true,
            enableDrag: true,
          );
        },
      ),
      MenuItemModel(
        id: 'prescriptions',
        label: getTranslation('profile.prescriptions'),
        description: getTranslation('profile.prescriptions_desc'),
        icon: Icons.description,
        iconColor: const Color(0xFFA855F7),
        badge: prescriptions.where((p) => p.isActive).length,
        onTap: () {
          Get.bottomSheet(
            SizedBox(
              height: screenHeight * 0.85,
              child: PrescriptionsModal(
                prescriptions: getAllPrescriptions(),
                onClose: Get.back,
                onDownload: (prescription) {
                  downloadPrescription(prescription);
                },
              ),
            ),
            isScrollControlled: true,
            enableDrag: true,
          );
        },
      ),
      MenuItemModel(
        id: 'addresses',
        label: getTranslation('profile.saved_addresses'),
        description: getTranslation('profile.saved_addresses_desc'),
        icon: Icons.location_on,
        iconColor: const Color(0xFFF97316),
        onTap: () {
          Get.bottomSheet(
            const AddressesBottomSheet(),
            isScrollControlled: true,
          );
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
        onTap: () => _settingsService.toggleNotifications(),
      ),
      SettingsItemModel(
        id: 'darkmode',
        label: getTranslation('profile.dark_mode'),
        icon: Icons.dark_mode,
        hasToggle: true,
        onTap: () => _themeService.toggleDarkMode(),
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
                          _settingsService.setLanguage(lang.key);
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
                                ? Colors.blue.withAlpha(26)
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
    Get.find<AuthService>().logout();
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

  // Update user profile
  Future<void> updateUserProfile(Map<String, dynamic> data) async {
    try {
      // Show loading
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      final response = await _profileRepository.updateUserProfile(data);

      // Close loading
      if (Get.isDialogOpen ?? false) Get.back();

      // Close modal
      if (Get.isBottomSheetOpen ?? false) Get.back();

      if (response != null) {
        // Update local user model if needed
        // Assuming response contains specific fields or success message
        // For now, we update the local currentUser with the specific fields we changed
        // Note: Ideally the backend returns the full updated user object.

        // Example: Update local fields
        String fullName =
            "${data['firstName']} ${data['middleName']} ${data['lastName']}"
                .trim();
        currentUser = currentUser.copyWith(
          name: fullName,
          email: data['email'],
          // Add other fields to UserModel if they exist
        );

        // Also update storage if necessary
        final storageService = Get.find<StorageService>();
        final storageUser = storageService.getUser();
        if (storageUser != null) {
          final updatedStorageUser = storageUser.copyWith(
            firstName: data['firstName'],
            lastName: data['lastName'],
            email: data['email'],
          );
          if (updatedStorageUser != null) {
            storageService.saveUser(updatedStorageUser);
          }
        }

        if (data.containsKey('notificationsEnabled')) {
          _settingsService.setNotifications(data['notificationsEnabled']);
        }

        Get.snackbar('Success', 'Profile updated successfully');
        update(); // Refresh UI
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();
      if (e is ApiException) {
        Get.snackbar(
          'Error',
          'Failed to update profile: ${e.response!.data['message']}',
        );
      } else {
        Get.snackbar('Error', 'Failed to update profile: $e');
      }
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

  // Update profile photo
  Future<void> updateProfilePhoto() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        // Show loading indicator
        Get.dialog(
          const Center(child: CircularProgressIndicator()),
          barrierDismissible: false,
        );

        String fileName = image.path.split('/').last;

        // Create FormData with the image
        dio.FormData formData = dio.FormData.fromMap({
          "image": await dio.MultipartFile.fromFile(
            image.path,
            filename: fileName,
          ),
        });

        // Call API
        final response = await ApiClient().patch(
          ApiConstants.changeProfilePhoto,
          formData,
        );

        // Close loading dialog
        if (Get.isDialogOpen ?? false) Get.back();

        // Check if response contains the new image URL
        // Assuming the response structure based on typical API patterns
        // Modify this based on actual API response
        String? newImageUrl;
        if (response is Map && response.containsKey('photoUrl')) {
          // Adjust based on nesting: response['data']['profileImage'] or similar
          // For now, let's assume the API returns the updated user object or the URL string
          if (response['photoUrl'] != null && response['photoUrl'] is String) {
            newImageUrl = response['photoUrl'];
            currentUser = currentUser.copyWith(imageUrl: newImageUrl);
            final storageService = Get.find<StorageService>();
            final savedUser = storageService.getUser();
            final updatedUser = savedUser?.copyWith(profileImage: newImageUrl);
            storageService.saveUser(updatedUser!);

            update();
          }
        }
        Get.snackbar('Success', 'Profile photo updated successfully');
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();
      log('Error updating profile photo: $e');
      Get.snackbar('Error', 'Failed to update profile photo');
    }
  }

  Future<void> fetchMedicalProfile() async {
    try {
      isLoadingMedicalProfile.value = true;
      final response = await _profileRepository.getMedicalProfile();
      log('Runtime type of response: ${response.runtimeType}');
      log('Response content: $response');

      if (response != null) {
        if (response is Map) {
          final mapData = Map<String, dynamic>.from(response);
          // Check if it's wrapped in 'data' dictionary
          if (mapData.containsKey('data') && mapData['data'] is Map) {
            medicalProfile.value = MedicalProfile.fromJson(
              Map<String, dynamic>.from(mapData['data']),
            );
          } else {
            medicalProfile.value = MedicalProfile.fromJson(mapData);
          }
        }
      } else {
        log('Response is null');
      }
    } catch (e) {
      log('Error fetching medical profile: $e');
    } finally {
      isLoadingMedicalProfile.value = false;
    }
  }

  Future<void> updateMedicalProfile(MedicalProfile updatedProfile) async {
    try {
      // Show loading
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      final response = await _profileRepository.updateMedicalProfile(
        updatedProfile.toJson(),
      );

      // Close loading
      if (Get.isDialogOpen ?? false) Get.back();

      if (response != null && response is Map<String, dynamic>) {
        medicalProfile.value = MedicalProfile.fromJson(response);
        Get.back(); // Close Edit Modal
        Get.snackbar('Success', 'Medical profile updated successfully');
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();
      log('Error updating medical profile: $e');
      Get.snackbar('Error', 'Failed to update medical profile');
    }
  }

  // Initialize family members
  void _initializeFamilyMembers() {
    familyMembers = RxList<FamilyMemberModel>.empty();
    fetchFamilyMembers();
  }

  // Fetch family members from API
  Future<void> fetchFamilyMembers() async {
    try {
      isLoadingFamilyMembers.value = true;
      final response = await _profileRepository.getFamilyMembers();
      if (response != null && response['data'] is List) {
        familyMembers.assignAll(
          (response['data'] as List)
              .map((item) => FamilyMemberModel.fromJson(item))
              .toList(),
        );
        update(); // Build UI with new data
      }
    } catch (e) {
      log('Error fetching family members: $e');
    } finally {
      isLoadingFamilyMembers.value = false;
    }
  }

  // Create family member
  Future<void> createFamilyMember(
    FamilyMemberModel member, {
    File? imageFile,
  }) async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      dynamic data;
      if (imageFile != null) {
        final Map<String, dynamic> memberJson = member.toJson();
        // Dio FormData requires String values for text fields usually, but standard JSON types often work if API handles it.
        // Safer to keep them as is or ensure they are primitives.
        // MultipartFile needs to be added.

        data = dio.FormData.fromMap({
          ...memberJson,
          "image": await dio.MultipartFile.fromFile(
            imageFile.path,
            filename: imageFile.path.split('/').last,
          ),
        });
      } else {
        data = member.toJson();
      }

      await _profileRepository.addFamilyMember(data);

      // Close loading
      if (Get.isDialogOpen ?? false) Get.back();
      if (Get.isBottomSheetOpen ?? false) Get.back();

      Get.snackbar('Success', 'Family member added successfully');

      Get.back();
      fetchFamilyMembers();
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();
      if (e is ApiException && e.response != null) {
        log('Error adding family member: ${e.response!.data}');
        Get.snackbar('Error', e.response!.data['errors'].toString());
      } else {
        Get.snackbar('Error', 'Failed to add family member: $e');
      }
    }
  }

  // Update family member
  Future<void> updateFamilyMemberDetails(
    String id,
    FamilyMemberModel member, {
    File? imageFile,
  }) async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      dynamic data;
      if (imageFile != null) {
        final Map<String, dynamic> memberJson = member.toJson();
        data = dio.FormData.fromMap({
          ...memberJson,
          "photo": await dio.MultipartFile.fromFile(
            imageFile.path,
            filename: imageFile.path.split('/').last,
          ),
        });
      } else {
        // We only send fields that are not null/modified.
        // For now, sending toJson() which filters nulls mostly.
        data = member.toJson();
      }

      await _profileRepository.updateFamilyMember(id, data);

      // Close loading
      if (Get.isDialogOpen ?? false) Get.back();

      Get.snackbar('Success', 'Family member updated successfully');

      if (Get.isBottomSheetOpen ?? false) Get.back(); // Close edit modal
      fetchFamilyMembers();
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();
      if (e is ApiException) {
        Get.snackbar('Error', e.response!.data['message']);
      } else {
        Get.snackbar('Error', 'Failed to update family member: $e');
      }
    }
  }

  // Delete family member
  Future<void> deleteFamilyMember(String id) async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      await _profileRepository.deleteFamilyMember(id);

      // Close loading
      if (Get.isDialogOpen ?? false) Get.back();

      Get.snackbar('Success', 'Family member deleted successfully');
      fetchFamilyMembers();
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();
      Get.snackbar('Error', 'Failed to delete family member: $e');
    }
  }
}
