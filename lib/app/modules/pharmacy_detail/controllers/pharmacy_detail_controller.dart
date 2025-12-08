import 'package:get/get.dart';
import '../models/pharmacy_detail_model.dart';
import '../models/doctor_detail_model.dart';

// Pharmacy detail controller manages pharmacy details and doctors
class PharmacyDetailController extends GetxController {
  // Observable properties for reactive UI updates
  final pharmacy = Rxn<PharmacyDetailModel>();
  final doctors = <DoctorDetailModel>[].obs;
  final selectedTab = 'overview'.obs;

  @override
  void onInit() {
    super.onInit();
    // Get pharmacy from arguments - can be any object with pharmacy data
    final args = Get.arguments;
    if (args != null) {
      // Convert any pharmacy-like object to PharmacyDetailModel
      pharmacy.value = _convertToPharmacyDetail(args);
    } else {
      // Create a default pharmacy if no arguments provided (for UI preview)
      pharmacy.value = PharmacyDetailModel(
        id: 1,
        name: 'HealthCare Pharmacy',
        distance: '0.5 km',
        rating: 4.6,
        workingHours: '8:00 AM - 10:00 PM',
        imageUrl:
            'https://images.unsplash.com/photo-1596522016734-8e6136fe5cfa?w=600',
        isOpen: true,
        address: '123 Main Street, Downtown, City',
        phone: '+1 (555) 123-4567',
        totalDoctors: 4,
      );
    }
    // Initialize doctors for this pharmacy
    _initializeDoctors();
  }

  // Convert any pharmacy-like object to PharmacyDetailModel
  PharmacyDetailModel _convertToPharmacyDetail(dynamic args) {
    if (args is PharmacyDetailModel) {
      return args;
    }

    // Handle dynamic object with pharmacy properties
    try {
      return PharmacyDetailModel(
        id: args.id ?? 1,
        name: args.name ?? 'Pharmacy',
        distance: args.distance ?? '0 km',
        rating: (args.rating ?? 4.5).toDouble(),
        workingHours: args.workingHours ?? '9:00 AM - 9:00 PM',
        imageUrl: args.imageUrl ?? '',
        isOpen: args.isOpen ?? true,
        address: args.address,
        phone: args.phone,
        totalDoctors: args.totalDoctors ?? 0,
      );
    } catch (e) {
      // Fallback to default pharmacy
      return PharmacyDetailModel(
        id: 1,
        name: 'Pharmacy',
        distance: '0 km',
        rating: 4.5,
        workingHours: '9:00 AM - 9:00 PM',
        imageUrl: '',
        isOpen: true,
        totalDoctors: 0,
      );
    }
  }

  // Initialize doctors with sample data
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
      // TODO: Implement directions
      Get.snackbar('Directions', 'Opening directions...');
    } catch (e) {
      Get.snackbar('Error', 'Failed to get directions: $e');
    }
  }

  // Call pharmacy
  Future<void> callPharmacy() async {
    try {
      // TODO: Implement phone call
      Get.snackbar('Call', 'Calling pharmacy...');
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
}
