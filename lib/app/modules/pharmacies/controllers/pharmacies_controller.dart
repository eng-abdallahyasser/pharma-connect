import 'package:get/get.dart';
import '../models/pharmacy_filter_model.dart';
import '../../home/models/pharmacy_model.dart';

class PharmaciesController extends GetxController {
  // Observable properties
  final searchQuery = ''.obs;
  final viewMode = 'list'.obs; // 'list' or 'map'
  final selectedPharmacyId = (-1).obs;

  // Pharmacy data
  late List<PharmacyModel> pharmacies;

  // Filters
  final filters = <PharmacyFilterModel>[].obs;
  final activeFilters = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializePharmacies();
    _initializeFilters();
  }

  void _initializePharmacies() {
    pharmacies = [
      PharmacyModel(
        id: 1,
        name: 'HealthCare Pharmacy',
        distance: '0.5 km',
        rating: 4.6,
        workingHours: '8:00 AM - 10:00 PM',
        imageUrl:
            'https://images.unsplash.com/photo-1596522016734-8e6136fe5cfa?w=600',
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
      PharmacyModel(
        id: 4,
        name: 'Quick Care Pharmacy',
        distance: '2.5 km',
        rating: 4.7,
        workingHours: '7:00 AM - 11:00 PM',
        imageUrl:
            'https://images.unsplash.com/photo-1596522016734-8e6136fe5cfa?w=600',
        isOpen: true,
        totalDoctors: 5,
        availableDoctors: 2,
      ),
      PharmacyModel(
        id: 5,
        name: 'Wellness Pharmacy',
        distance: '3.0 km',
        rating: 4.4,
        workingHours: '8:00 AM - 8:00 PM',
        imageUrl:
            'https://images.unsplash.com/photo-1596522016734-8e6136fe5cfa?w=600',
        isOpen: true,
        totalDoctors: 2,
        availableDoctors: 1,
      ),
    ];
  }

  void _initializeFilters() {
    filters.assignAll([
      PharmacyFilterModel(id: 'open_now', label: 'Open Now'),
      PharmacyFilterModel(id: 'within_5km', label: 'Within 5km'),
      PharmacyFilterModel(id: '24_7', label: '24/7'),
    ]);
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void toggleViewMode() {
    viewMode.value = viewMode.value == 'list' ? 'map' : 'list';
  }

  void setViewMode(String mode) {
    viewMode.value = mode;
  }

  void toggleFilter(String filterId) {
    if (activeFilters.contains(filterId)) {
      activeFilters.remove(filterId);
    } else {
      activeFilters.add(filterId);
    }
    // Update filters UI
    filters.assignAll(
      filters.map((filter) {
        if (filter.id == filterId) {
          return filter.copyWith(isActive: !filter.isActive);
        }
        return filter;
      }).toList(),
    );
  }

  void selectPharmacy(int pharmacyId) {
    selectedPharmacyId.value = pharmacyId;
  }

  void clearPharmacySelection() {
    selectedPharmacyId.value = -1;
  }

  void onPharmacySelect(PharmacyModel pharmacy) {
    Get.toNamed('/pharmacy-detail', arguments: pharmacy);
  }

  List<PharmacyModel> getFilteredPharmacies() {
    List<PharmacyModel> filtered = pharmacies;

    // Apply search filter
    if (searchQuery.value.isNotEmpty) {
      filtered = filtered
          .where((p) =>
              p.name.toLowerCase().contains(searchQuery.value.toLowerCase()))
          .toList();
    }

    // Apply active filters
    if (activeFilters.isNotEmpty) {
      filtered = filtered.where((pharmacy) {
        bool matches = true;

        if (activeFilters.contains('open_now') && !pharmacy.isOpen) {
          matches = false;
        }

        if (activeFilters.contains('within_5km')) {
          final distance =
              double.tryParse(pharmacy.distance.split(' ')[0]) ?? 0;
          if (distance > 5) {
            matches = false;
          }
        }

        if (activeFilters.contains('24_7')) {
          if (!pharmacy.workingHours.contains('24')) {
            matches = false;
          }
        }

        return matches;
      }).toList();
    }

    return filtered;
  }
}
