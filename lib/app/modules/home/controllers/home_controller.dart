import 'package:get/get.dart';
import 'package:pharma_connect/app/locales/translations.dart';
import '../models/doctor_model.dart';
import '../models/pharmacy_model.dart';
import '../models/health_tip_model.dart';

class HomeController extends GetxController {
  final searchQuery = ''.obs;
  final selectedDoctorIndex = (-1).obs;

  late List<DoctorModel> doctors;
  late List<PharmacyModel> pharmacies;
  late List<HealthTipModel> healthTips;

  @override
  void onInit() {
    super.onInit();
    _initializeDoctors();
    _initializePharmacies();
    _initializeHealthTips();
  }

  void _initializeDoctors() {
    doctors = [
      DoctorModel(
        id: 1,
        name: 'Dr. Sarah Johnson',
        specialization: 'General Physician',
        imageUrl:
            'https://images.unsplash.com/photo-1659353888906-adb3e0041693?w=400',
        rating: 4.8,
        status: 'available',
      ),
      DoctorModel(
        id: 2,
        name: 'Dr. Michael Chen',
        specialization: 'Cardiologist',
        imageUrl:
            'https://images.unsplash.com/photo-1712215544003-af10130f8eb3?w=400',
        rating: 4.9,
        status: 'available',
      ),
      DoctorModel(
        id: 3,
        name: 'Dr. Emily Roberts',
        specialization: 'Dermatologist',
        imageUrl:
            'https://images.unsplash.com/photo-1758691463626-0ab959babe00?w=400',
        rating: 4.7,
        status: 'busy',
      ),
    ];
  }

  void _initializePharmacies() {
    pharmacies = [
      PharmacyModel(
        id: 1,
        name: 'HealthCare Pharmacy',
        distance: '0.5 km',
        rating: 4.7,
        workingHours: '8:00 AM - 10:00 PM',
        imageUrl:
            'https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=600',
        isOpen: true,
        totalDoctors: 4,
        availableDoctors: 3,
      ),
      PharmacyModel(
        id: 2,
        name: 'MediPlus 24/7',
        distance: '1.2 km',
        rating: 4.8,
        workingHours: 'Open 24 Hours',
        imageUrl:
            'https://images.unsplash.com/photo-1596522016734-8e6136fe5cfa?w=600',
        isOpen: true,
        totalDoctors: 6,
        availableDoctors: 4,
      ),
      PharmacyModel(
        id: 3,
        name: 'City Pharmacy',
        distance: '2.0 km',
        rating: 4.5,
        workingHours: '9:00 AM - 9:00 PM',
        imageUrl:
            'https://images.unsplash.com/photo-1596522016734-8e6136fe5cfa?w=600',
        isOpen: false,
        totalDoctors: 3,
        availableDoctors: 0,
      ),
    ];
  }

  void _initializeHealthTips() {
    healthTips = [
      HealthTipModel(
        id: 1,
        title: getTranslation('home.stay_hydrated'),
        description: getTranslation('home.stay_hydrated_desc'),
        imageUrl:
            'https://images.unsplash.com/photo-1535914254981-b5012eebbd15?w=600',
      ),
      HealthTipModel(
        id: 2,
        title: getTranslation('home.regular_exercise'),
        description: getTranslation('home.regular_exercise_desc'),
        imageUrl:
            'https://images.unsplash.com/photo-1535914254981-b5012eebbd15?w=600',
      ),
      HealthTipModel(
        id: 3,
        title: getTranslation('home.balanced_diet'),
        description: getTranslation('home.balanced_diet_desc'),
        imageUrl:
            'https://images.unsplash.com/photo-1535914254981-b5012eebbd15?w=600',
      ),
    ];
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void selectDoctor(int index) {
    selectedDoctorIndex.value = index;
  }

  void onChatWithDoctor(DoctorModel doctor) {
    // Handle chat navigation
    Get.toNamed('/chat', arguments: doctor);
  }

  void onNavigateToMedicines() {
    Get.toNamed('/medicines');
  }

  void onNavigateToNotifications() {
    Get.toNamed('/notifications');
  }

  void onPharmacySelect(PharmacyModel pharmacy) {
    Get.toNamed('/pharmacy-detail', arguments: pharmacy);
  }
}
