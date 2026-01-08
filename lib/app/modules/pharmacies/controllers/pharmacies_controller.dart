import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:pharma_connect/app/modules/navigation/controllers/navigation_controller.dart';
import 'package:pharma_connect/app/core/services/storage_service.dart';
import 'package:pharma_connect/app/modules/home/models/address_model.dart';
import 'package:pharma_connect/app/modules/pharmacy_detail/models/pharmacy_detail_model.dart';
import '../models/pharmacy_filter_model.dart';
import '../../home/models/pharmacy_model.dart';
import 'package:pharma_connect/app/data/providers/pharmacies_provider.dart';
import 'dart:async';

class PharmaciesController extends GetxController {
  // Observable properties
  final searchQuery = ''.obs;
  final viewMode = 'list'.obs; // 'list' or 'map'
  final selectedPharmacyId = (-1).obs;
  final isLoading = false.obs;
  final isFiltersShown = false.obs;
  final distanceFilters = {'within_5km', 'within_2km'};

  // Pharmacy data
  final pharmacies = <PharmacyModel>[].obs;
  final pharmacyLocations = <int, LatLng>{}.obs;

  LatLng? get userLocation => _selectedAddress != null
      ? LatLng(_selectedAddress!.latitude, _selectedAddress!.longitude)
      : null;

  final savedAddressesList = <LatLng>[].obs;

  // Filters
  final filters = <PharmacyFilterModel>[].obs;
  final activeFilters = <String>[].obs;

  Timer? _debounce;
  late final PharmaciesProvider _provider;
  AddressModel? _selectedAddress;

  final hasAddresses = false.obs;

  @override
  void onInit() {
    super.onInit();
    _provider = Get.find<PharmaciesProvider>();

    if (!_checkAndHandleAddresses()) {
      return;
    }

    _loadSelectedAddress();
    if (_selectedAddress != null) {
      fetchNearbyPharmacies();
    }
    _initializeFilters();
  }

  bool _checkAndHandleAddresses() {
    final storageService = Get.find<StorageService>();
    final addresses = storageService.getAddresses();

    if (addresses == null || addresses.isEmpty) {
      hasAddresses.value = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showNoAddressDialog();
      });
      return false;
    }
    hasAddresses.value = true;
    return true;
  }

  void _showNoAddressDialog() {
    Get.defaultDialog(
      title: "Missing Address",
      middleText: "Please add your address to be able to get nearby entities.",
      textConfirm: "Add Address",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        Get.find<NavigationController>().navigateToRoute('/profile');
      },
      barrierDismissible: false,
    );
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
      savedAddressesList.assignAll(
        addressList
            .where((element) => !element.isSelected)
            .map((e) => LatLng(e.latitude, e.longitude))
            .toList(),
      );
      log(
        "Selected Address pharmacies_controller: ${_selectedAddress?.toJson()}"
        "  Saved Addresses: ${savedAddressesList.length}",
      );
    }
  }

  Future<void> fetchPharmacies({String? query}) async {
    isLoading.value = true;
    try {
      final response = await _provider.searchBranches(search: query);
      final data = response['data'] as List;
      _processPharmacyData(data);
    } catch (e) {
      log('Error fetching pharmacies: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchNearbyPharmacies() async {
    if (_selectedAddress == null) return;

    isLoading.value = true;
    try {
      final response = await _provider.getNearbyBranches(
        lat: _selectedAddress!.latitude,
        lng: _selectedAddress!.longitude,
      );
      final data = response['data'] as List;
      _processPharmacyData(data);
    } catch (e) {
      log(name: 'PharmaciesController', 'Error fetching nearby pharmacies: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _processPharmacyData(List data) {
    pharmacyLocations.clear();
    pharmacies.assignAll(
      data.map((item) {
        final localizedName = item['localizedName'] as Map<String, dynamic>?;
        final isAlwaysOpen = item['isAlwaysOpen'] == true;

        final lat = (item['latitude'] as num?)?.toDouble();
        final lng = (item['longitude'] as num?)?.toDouble();
        String? distance = (item['distance'] as num?)?.toStringAsFixed(2);
        distance ??= _calculateDistance(lat, lng);

        final id = (item['id'] as String).hashCode;

        if (lat != null && lng != null) {
          pharmacyLocations[id] = LatLng(lat, lng);
        }

        return PharmacyModel(
          id: item['id'],
          name: localizedName?['en'] ?? 'Pharmacy',
          distance: "$distance km",
          rating: (item['averageRating'] as num?)?.toDouble() ?? 0.0,
          workingHours: isAlwaysOpen ? '24 Hours' : 'Open',
          imageUrl:
              'https://images.unsplash.com/photo-1596522016734-8e6136fe5cfa?w=600',
          isOpen: item['isActive'] == true, // Check logic on nearby vs search
          totalDoctors:
              (item['doctorsCount'] != null && item['doctorsCount'] != 0)
              ? item['doctorsCount']
              : 7,
          availableDoctors:
              (item['onlineDoctors'] != null && item['onlineDoctors'] != 0)
              ? item['onlineDoctors']
              : 7,
        );
      }).toList(),
    );
  }

  void _initializeFilters() {
    filters.assignAll([
      PharmacyFilterModel(
        id: 'open_now',
        label: 'pharmacies.filter_open_now'.tr,
      ),
      PharmacyFilterModel(
        id: 'within_5km',
        label: 'pharmacies.filter_within_5km'.tr,
      ),
      PharmacyFilterModel(
        id: 'within_2km',
        label: 'pharmacies.filter_within_2km'.tr,
      ),
      PharmacyFilterModel(id: '24_7', label: 'pharmacies.filter_24_7'.tr),
    ]);
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isEmpty && _selectedAddress != null) {
        fetchNearbyPharmacies();
      } else {
        fetchPharmacies(query: query);
      }
    });
  }

  void toggleViewMode() {
    viewMode.value = viewMode.value == 'list' ? 'map' : 'list';
  }

  void setViewMode(String mode) {
    viewMode.value = mode;
  }

  void toggleFilter(String filterId) {
    // Define mutually exclusive distance filters
    const distanceFilters = {'within_5km', 'within_2km'};

    // Check if it's a distance filter
    final isDistanceFilter = distanceFilters.contains(filterId);

    if (isDistanceFilter) {
      // For distance filters: they should work like radio buttons
      final wasActive = activeFilters.contains(filterId);

      // Clear all distance filters first
      activeFilters.removeWhere((id) => distanceFilters.contains(id));

      // Set all distance filters to inactive in UI
      for (int i = 0; i < filters.length; i++) {
        if (distanceFilters.contains(filters[i].id)) {
          filters[i] = filters[i].copyWith(isActive: false);
        }
      }

      // If it wasn't active before, activate it now
      if (!wasActive) {
        activeFilters.add(filterId);

        // Update the specific filter to active
        for (int i = 0; i < filters.length; i++) {
          if (filters[i].id == filterId) {
            filters[i] = filters[i].copyWith(isActive: true);
            break;
          }
        }
      }
    } else {
      // For non-distance filters: normal toggle behavior
      if (activeFilters.contains(filterId)) {
        activeFilters.remove(filterId);
      } else {
        activeFilters.add(filterId);
      }

      // Update UI for the specific filter
      for (int i = 0; i < filters.length; i++) {
        if (filters[i].id == filterId) {
          filters[i] = filters[i].copyWith(isActive: !filters[i].isActive);
          break;
        }
      }
    }
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
    // Search is handled by API now
    /* if (searchQuery.value.isNotEmpty) {
      filtered = filtered
          .where(
            (p) =>
                p.name.toLowerCase().contains(searchQuery.value.toLowerCase()),
          )
          .toList();
    } */

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
        if (activeFilters.contains('within_2km')) {
          final distance =
              double.tryParse(pharmacy.distance.split(' ')[0]) ?? 0;
          if (distance > 2) {
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

  String _calculateDistance(double? lat, double? long) {
    if (lat == null || long == null || _selectedAddress == null) {
      return 'location not found';
    }

    try {
      final Distance distance = const Distance();
      final double km = distance.as(
        LengthUnit.Kilometer,
        LatLng(_selectedAddress!.latitude, _selectedAddress!.longitude),
        LatLng(lat, long),
      );

      return km.toStringAsFixed(1);
    } catch (e) {
      log('Error calculating distance: $e');
      return 'calculation error: $e';
    }
  }

  void onFilterPressed() {
    isFiltersShown.value = !isFiltersShown.value;
  }

  void orderMedicines(PharmacyModel pharmacy) {
    Get.toNamed(
      '/pharmacy-request',
      arguments: PharmacyDetailModel(
        id: pharmacy.id,
        telephones: [], // Placeholder
        whatsAppTelephone: '', // Placeholder
        ratingCount: pharmacy.rating.toInt(),
        latitude: 0.0, // info not in PharmacyModel
        longitude: 0.0, // info not in PharmacyModel
        isActive: pharmacy.isOpen,
        isAlwaysOpen: pharmacy.workingHours.contains('24'),
        localizedName: {'en': pharmacy.name},
        addressMap: {},
        city: {},
        provider: {},
      ),
    );
  }
}
