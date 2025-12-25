import 'package:get/get.dart';
import '../models/doctor_model.dart';
import '../models/consultation_model.dart';
import '../services/doctors_service.dart';

// Consultations controller manages doctor consultations and scheduling
class ConsultationsController extends GetxController {
  // Observable properties for reactive UI updates
  final currentTabIndex = 0.obs; // 0: Available, 1: Upcoming, 2: History
  final searchQuery = ''.obs;
  final selectedDoctor = Rxn<DoctorModel>();
  final isLoadingDoctors = false.obs;

  // Lists of doctors and consultations
  final availableDoctors = <DoctorModel>[].obs;
  late List<ConsultationModel> upcomingConsultations;
  late List<ConsultationModel> pastConsultations;

  // Services
  late DoctorsService _doctorsService;

  @override
  void onInit() {
    super.onInit();
    // Initialize services
    _doctorsService = Get.put(DoctorsService());

    // Initialize all data when controller is created
    _initializeAvailableDoctors();
    _initializeUpcomingConsultations();
    _initializePastConsultations();
  }

  // Fetch available doctors from API
  Future<void> _initializeAvailableDoctors() async {
    isLoadingDoctors.value = true;
    try {
      // TODO: Get user's actual location
      // For now, using the coordinates from the API example
      final doctors = await _doctorsService.fetchNearbyDoctors(
        lat: 30.0583958,
        lng: 31.25982,
        radius: 5.0,
      );

      availableDoctors.value = doctors;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load doctors: $e');
    } finally {
      isLoadingDoctors.value = false;
    }
  }

  // Public method to refresh doctors list
  Future<void> refreshDoctors() async {
    await _initializeAvailableDoctors();
  }

  // Initialize upcoming consultations with sample data
  void _initializeUpcomingConsultations() {
    upcomingConsultations = [
      ConsultationModel(
        id: 1,
        doctorName: 'Dr. Sarah Johnson',
        specialization: 'General Physician',
        date: 'Dec 5, 2024',
        time: '10:00 AM',
        type: 'Video Call',
        status: 'confirmed',
      ),
      ConsultationModel(
        id: 2,
        doctorName: 'Dr. Michael Chen',
        specialization: 'Cardiologist',
        date: 'Dec 7, 2024',
        time: '2:30 PM',
        type: 'Chat',
        status: 'pending',
      ),
      ConsultationModel(
        id: 3,
        doctorName: 'Dr. James Wilson',
        specialization: 'Orthopedic Surgeon',
        date: 'Dec 10, 2024',
        time: '4:00 PM',
        type: 'Phone Call',
        status: 'confirmed',
      ),
    ];
  }

  // Initialize past consultations with sample data
  void _initializePastConsultations() {
    pastConsultations = [
      ConsultationModel(
        id: 1,
        doctorName: 'Dr. Emily Roberts',
        specialization: 'Dermatologist',
        date: 'Nov 28, 2024',
        time: '3:00 PM',
        type: 'Video Call',
        status: 'completed',
        hasPrescription: true,
      ),
      ConsultationModel(
        id: 2,
        doctorName: 'Dr. Sarah Johnson',
        specialization: 'General Physician',
        date: 'Nov 15, 2024',
        time: '11:00 AM',
        type: 'Chat',
        status: 'completed',
        hasPrescription: false,
      ),
      ConsultationModel(
        id: 3,
        doctorName: 'Dr. Michael Chen',
        specialization: 'Cardiologist',
        date: 'Nov 5, 2024',
        time: '1:30 PM',
        type: 'Phone Call',
        status: 'completed',
        hasPrescription: true,
      ),
    ];
  }

  // Update search query and filter doctors
  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  // Get filtered available doctors based on search query
  List<DoctorModel> getFilteredDoctors() {
    if (searchQuery.value.isEmpty) {
      return availableDoctors;
    }

    final query = searchQuery.value.toLowerCase();
    return availableDoctors.where((doctor) {
      return doctor.name.toLowerCase().contains(query) ||
          (doctor.specialization?.toLowerCase().contains(query) ?? false);
    }).toList();
  }

  // Change current tab
  void changeTab(int index) {
    currentTabIndex.value = index;
  }

  // Select a doctor
  void selectDoctor(DoctorModel doctor) {
    selectedDoctor.value = doctor;
  }

  // Clear selected doctor
  void clearSelectedDoctor() {
    selectedDoctor.value = null;
  }

  // Handle chat with doctor
  Future<void> chatWithDoctor(DoctorModel doctor) async {
    try {
      selectDoctor(doctor);
      // TODO: Navigate to chat screen
      Get.snackbar('Chat', 'Opening chat with ${doctor.name}');
    } catch (e) {
      Get.snackbar('Error', 'Failed to start chat: $e');
    }
  }

  // Handle call with doctor
  Future<void> callDoctor(DoctorModel doctor) async {
    try {
      selectDoctor(doctor);
      // TODO: Implement call functionality
      Get.snackbar('Call', 'Calling ${doctor.name}');
    } catch (e) {
      Get.snackbar('Error', 'Failed to call doctor: $e');
    }
  }

  // Handle booking consultation
  Future<void> bookConsultation(DoctorModel doctor) async {
    try {
      selectDoctor(doctor);
      // TODO: Navigate to booking screen
      Get.snackbar('Booking', 'Opening booking for ${doctor.name}');
    } catch (e) {
      Get.snackbar('Error', 'Failed to book consultation: $e');
    }
  }

  // Handle starting video call for upcoming consultation
  Future<void> startVideoCall(ConsultationModel consultation) async {
    try {
      // TODO: Implement video call functionality
      Get.snackbar(
        'Video Call',
        'Starting call with ${consultation.doctorName}',
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to start call: $e');
    }
  }

  // Handle joining chat for upcoming consultation
  Future<void> joinChat(ConsultationModel consultation) async {
    try {
      // TODO: Navigate to chat screen
      Get.snackbar('Chat', 'Joining chat with ${consultation.doctorName}');
    } catch (e) {
      Get.snackbar('Error', 'Failed to join chat: $e');
    }
  }

  // Handle viewing prescription from past consultation
  Future<void> viewPrescription(ConsultationModel consultation) async {
    try {
      // TODO: Navigate to prescription view
      Get.snackbar(
        'Prescription',
        'Viewing prescription from ${consultation.doctorName}',
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to view prescription: $e');
    }
  }

  // Cancel upcoming consultation
  Future<void> cancelConsultation(ConsultationModel consultation) async {
    try {
      // TODO: Make API call to cancel consultation
      upcomingConsultations.removeWhere((c) => c.id == consultation.id);
      Get.snackbar('Success', 'Consultation cancelled');
    } catch (e) {
      Get.snackbar('Error', 'Failed to cancel consultation: $e');
    }
  }

  // Reschedule consultation
  Future<void> rescheduleConsultation(ConsultationModel consultation) async {
    try {
      // TODO: Navigate to rescheduling screen
      Get.snackbar(
        'Reschedule',
        'Opening reschedule for ${consultation.doctorName}',
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to reschedule: $e');
    }
  }

  // Get count of upcoming consultations
  int getUpcomingCount() {
    return upcomingConsultations.length;
  }

  // Get count of confirmed upcoming consultations
  int getConfirmedCount() {
    return upcomingConsultations.where((c) => c.isConfirmed).length;
  }

  // Get all upcoming consultations
  List<ConsultationModel> getAllUpcoming() {
    return upcomingConsultations;
  }

  // Get all past consultations
  List<ConsultationModel> getAllPast() {
    return pastConsultations;
  }
}
