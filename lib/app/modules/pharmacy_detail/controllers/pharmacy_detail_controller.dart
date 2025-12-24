import 'dart:developer';

import 'package:get/get.dart';
import 'package:pharma_connect/app/core/services/storage_service.dart';
import 'package:pharma_connect/app/modules/home/models/address_model.dart';
import 'package:pharma_connect/app/modules/home/models/pharmacy_model.dart';
import '../models/pharmacy_detail_model.dart';
import '../models/doctor_detail_model.dart';
import '../services/pharmacy_detail_repository.dart';
import '../widgets/rating_dialog.dart';
import 'package:flutter/material.dart';

// Pharmacy detail controller manages pharmacy details and doctors
class PharmacyDetailController extends GetxController {
  final PharmacyDetailRepository _repository = PharmacyDetailRepository();

  // Observable properties for reactive UI updates
  final pharmacy = Rxn<PharmacyDetailModel>();
  final doctors = <DoctorDetailModel>[].obs;
  final selectedTab = 'overview'.obs;
    AddressModel? _selectedAddress;

  @override
  Future<void> onInit() async {
    super.onInit();
    // Get pharmacy from arguments - expecting ID or object with ID
    final args = Get.arguments;
    String? pharmacyId;
    final PharmacyModel ph = Get.arguments;

    if (args is String) {
      pharmacyId = args;
    } else if (args is Map && args['id'] != null) {
      pharmacyId = args['id'].toString();
    } else {
      // Default ID if no arguments provided (for testing as per user request)
      pharmacyId = ph.id;
    }
    _loadSelectedAddress();

    final pharmacyDetail = await fetchPharmacyDetail(pharmacyId);
    if (pharmacyDetail != null) {
      pharmacyDetail.calculateDistance(_selectedAddress!);
      pharmacy.value = pharmacyDetail;
    }
  }

  void _loadSelectedAddress() {
    final storageService = Get.find<StorageService>();
    final addresses = storageService.getAddresses();
    if (addresses != null) {
      final addressList = addresses
          .map((e) => AddressModel.fromJson(e))
          .toList();
      _selectedAddress = addressList.firstWhereOrNull(
        (element) => element.isSelected,
      );
      log("Selected Address pharmacies_controller: ${_selectedAddress?.toJson()}");
    }
  }

  Future<PharmacyDetailModel?> fetchPharmacyDetail(String id) async {
    try {
      _initializeDoctors();
      return await _repository.getPharmacyDetail(id);
      

    } catch (e) {
      Get.snackbar('Error', 'Failed to load pharmacy details: $e');
      return null;
    }
  }

  // Initialize doctors with sample data (Preserved for UI structure as API doesn't return doctors yet)
  void _initializeDoctors() {
    doctors.value = [
      DoctorDetailModel(
        id: 1,
        name: 'Dr. Sarah Johnson',
        specialization: 'General Physician',
        photo:
            'https://images.unsplash.com/photo-1594824476967-48c8b964273f?w=200',
        workingHours: '9:00 AM - 5:00 PM',
        rating: 4.9,
        experience: '12 years',
        consultationFee: '\$50',
        isAvailable: true,
      ),
      DoctorDetailModel(
        id: 2,
        name: 'Dr. Michael Chen',
        specialization: 'Cardiologist',
        photo:
            'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=200',
        workingHours: '10:00 AM - 6:00 PM',
        rating: 4.8,
        experience: '15 years',
        consultationFee: '\$80',
        isAvailable: true,
      ),
      DoctorDetailModel(
        id: 3,
        name: 'Dr. Emily Roberts',
        specialization: 'Dermatologist',
        photo:
            'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=200',
        workingHours: '11:00 AM - 7:00 PM',
        rating: 4.7,
        experience: '10 years',
        consultationFee: '\$65',
        isAvailable: false,
      ),
      DoctorDetailModel(
        id: 4,
        name: 'Dr. James Wilson',
        specialization: 'Pediatrician',
        photo:
            'https://images.unsplash.com/photo-1622253692010-333f2da6031d?w=200',
        workingHours: '8:00 AM - 4:00 PM',
        rating: 4.9,
        experience: '18 years',
        consultationFee: '\$55',
        isAvailable: true,
      ),
    ];
  }

  // Select tab
  void selectTab(String tab) {
    selectedTab.value = tab;
  }

  // Get available doctors
  List<DoctorDetailModel> getAvailableDoctors() {
    return doctors.where((d) => d.isAvailable).toList();
  }

  // Get available doctors count
  int getAvailableDoctorsCount() {
    return getAvailableDoctors().length;
  }

  // Get all doctors
  List<DoctorDetailModel> getAllDoctors() {
    return doctors;
  }

  // Chat with doctor
  Future<void> chatWithDoctor(int doctorId) async {
    try {
      final doctor = doctors.firstWhereOrNull((d) => d.id == doctorId);
      if (doctor == null) {
        Get.snackbar('Error', 'Doctor not found');
        return;
      }

      if (!doctor.isAvailable) {
        Get.snackbar('Unavailable', 'This doctor is currently busy');
        return;
      }

      // Navigate to chat screen
      Get.toNamed('/chat');
    } catch (e) {
      Get.snackbar('Error', 'Failed to start chat: $e');
    }
  }

  // Book appointment
  Future<void> bookAppointment(int doctorId) async {
    try {
      final doctor = doctors.firstWhereOrNull((d) => d.id == doctorId);
      if (doctor == null) {
        Get.snackbar('Error', 'Doctor not found');
        return;
      }

      if (!doctor.isAvailable) {
        Get.snackbar('Unavailable', 'This doctor is currently busy');
        return;
      }

      // TODO: Implement appointment booking
      Get.snackbar('Success', 'Appointment booking coming soon');
    } catch (e) {
      Get.snackbar('Error', 'Failed to book appointment: $e');
    }
  }

  // Order medicines
  Future<void> orderMedicines() async {
    try {
      // TODO: Implement medicine ordering
      Get.snackbar('Order', 'Medicine ordering coming soon');
    } catch (e) {
      Get.snackbar('Error', 'Failed to order medicines: $e');
    }
  }

  // Get directions
  Future<void> getDirections() async {
    try {
      // Using data from pharmacy model if available
      if (pharmacy.value != null) {
        Get.snackbar(
          'Directions',
          'Opening directions to ${pharmacy.value!.name}...',
        );
        // here we could use latitude/longitude from pharmacy.value
      } else {
        Get.snackbar('Directions', 'Opening directions...');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to get directions: $e');
    }
  }

  // Call pharmacy
  Future<void> callPharmacy() async {
    try {
      if (pharmacy.value?.phone != null) {
        Get.snackbar('Call', 'Calling ${pharmacy.value!.phone}...');
      } else {
        Get.snackbar('Call', 'Calling pharmacy...');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to call: $e');
    }
  }

  // Share pharmacy
  Future<void> sharePharmacy() async {
    try {
      // TODO: Implement share functionality
      Get.snackbar('Share', 'Sharing pharmacy...');
    } catch (e) {
      Get.snackbar('Error', 'Failed to share: $e');
    }
  }

  // Open rating dialog
  void openRatingDialog() {
    Get.dialog(
      RatingDialog(onSubmit: (rating, notes) => _submitRating(rating, notes)),
    );
  }

  // Submit rating
  Future<void> _submitRating(double rating, String? notes) async {
    try {
      if (pharmacy.value?.id == null) return;

      // Show loading
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      await _repository.ratePharmacy(pharmacy.value!.id, rating, notes);

      if (Get.isDialogOpen == true) Get.back(); // Close loading

      Get.snackbar(
        'Success',
        'Thank you for your rating!',

      );

      // Refresh details
      fetchPharmacyDetail(pharmacy.value!.id);
    } catch (e) {
      if (Get.isDialogOpen == true) Get.back(); // Close loading if open

      Get.snackbar(
        'Error',
        'Failed to submit rating: $e',
      );
    }
  }

  
}
