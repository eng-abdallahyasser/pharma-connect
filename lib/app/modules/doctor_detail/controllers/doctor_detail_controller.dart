import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_connect/app/modules/consultations/models/doctor_model.dart';
import 'package:pharma_connect/app/modules/consultations/services/doctors_repository.dart';
import 'package:pharma_connect/app/modules/pharmacy_detail/widgets/rating_dialog.dart';

// Doctor detail controller manages single doctor details and interactions
class DoctorDetailController extends GetxController {
  // Observable properties for reactive UI updates
  final doctor = Rxn<DoctorModel>();
  final isLoading = false.obs;
  final selectedTimeSlot = Rxn<String>();
  final selectedDate = Rxn<DateTime>();

  // Available time slots for booking
  final availableTimeSlots = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Get doctor from arguments
    final args = Get.arguments;
    if (args is DoctorModel) {
      doctor.value = args;
      _initializeTimeSlots();
    } else {
      Get.snackbar('Error', 'Doctor details not found');
      Get.back();
    }
  }

  // Initialize available time slots
  void _initializeTimeSlots() {
    // Sample time slots - in real app, fetch from API
    availableTimeSlots.value = [
      '09:00 AM',
      '10:00 AM',
      '11:00 AM',
      '02:00 PM',
      '03:00 PM',
      '04:00 PM',
      '05:00 PM',
    ];
    // Set default selected date to today
    selectedDate.value = DateTime.now();
  }

  // Select a time slot
  void selectTimeSlot(String slot) {
    selectedTimeSlot.value = slot;
  }

  // Select a date
  void selectDate(DateTime date) {
    selectedDate.value = date;
    selectedTimeSlot.value = null; // Reset time slot when date changes
  }

  // Chat with doctor
  Future<void> chatWithDoctor() async {
    try {
      if (doctor.value == null) return;

      if (!doctor.value!.isOnline) {
        Get.snackbar('Unavailable', 'This doctor is currently offline');
        return;
      }

      // Navigate to chat screen
      Get.toNamed('/chat', arguments: doctor.value);
    } catch (e) {
      Get.snackbar('Error', 'Failed to start chat: $e');
    }
  }

  // Call doctor
  Future<void> callDoctor() async {
    try {
      if (doctor.value == null) return;

      if (!doctor.value!.isOnline) {
        Get.snackbar('Unavailable', 'This doctor is currently offline');
        return;
      }

      Get.snackbar('Calling', 'Initiating call with ${doctor.value!.name}...');
    } catch (e) {
      Get.snackbar('Error', 'Failed to call doctor: $e');
    }
  }

  // Book appointment
  Future<void> bookAppointment() async {
    try {
      if (doctor.value == null) return;

      if (selectedDate.value == null || selectedTimeSlot.value == null) {
        Get.snackbar('Required', 'Please select a date and time slot');
        return;
      }

      isLoading.value = true;

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      isLoading.value = false;

      Get.snackbar(
        'Success',
        'Appointment booked with ${doctor.value!.name} on ${_formatDate(selectedDate.value!)} at ${selectedTimeSlot.value}',
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to book appointment: $e');
    }
  }

  // Format date for display
  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  // Get formatted rating
  String get formattedRating {
    if (doctor.value?.averageRating == null ||
        doctor.value!.averageRating == 0) {
      return 'No rating yet';
    }
    return doctor.value!.averageRating.toStringAsFixed(1);
  }

  // Open rating dialog
  void openRatingDialog() {
    Get.dialog(
      RatingDialog(
        title: 'Rate Doctor',
        onSubmit: (rating, notes) => _submitRating(rating, notes),
      ),
    );
  }

  // Submit rating
  Future<void> _submitRating(double rating, String? notes) async {
    try {
      if (doctor.value?.id == null) return;

      // Show loading
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      final repository = Get.find<DoctorsRepository>();
      await repository.rateDoctor(doctor.value!.id, rating, notes);

      if (Get.isDialogOpen == true) Get.back(); // Close loading

      Get.snackbar('Success', 'Thank you for your rating!');

      // Refresh details or just update locally if needed
      // For now, we assume the user is happy with the feedback
    } catch (e) {
      if (Get.isDialogOpen == true) Get.back(); // Close loading if open

      Get.snackbar('Error', 'Failed to submit rating: $e');
    }
  }

  // Get distance text
  String get distanceText {
    if (doctor.value?.distance == null) {
      return 'Distance unknown';
    }
    return '${doctor.value!.distance.toStringAsFixed(1)} km away';
  }
}
