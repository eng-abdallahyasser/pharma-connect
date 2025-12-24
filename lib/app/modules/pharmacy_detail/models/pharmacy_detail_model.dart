// Pharmacy detail model representing detailed pharmacy information
import 'dart:developer';

import 'package:latlong2/latlong.dart';
import 'package:pharma_connect/app/modules/home/models/address_model.dart';

class PharmacyDetailModel {
  final String id;
  final List<String> telephones;
  final String whatsAppTelephone;
  final int ratingCount;
  final double latitude;
  final double longitude;
  String? distance;
  final bool isActive;
  final bool isAlwaysOpen;
  final Map<String, dynamic> localizedName;
  final Map<String, dynamic> addressMap;
  final Map<String, dynamic> city;
  final Map<String, dynamic> provider;

  PharmacyDetailModel({
    required this.id,
    required this.telephones,
    required this.whatsAppTelephone,
    required this.ratingCount,
    required this.latitude,
    required this.longitude,
    required this.isActive,
    required this.isAlwaysOpen,
    required this.localizedName,
    required this.addressMap,
    required this.city,
    required this.provider,
  });

  factory PharmacyDetailModel.fromJson(Map<String, dynamic> json) {
    return PharmacyDetailModel(
      id: json['id'] as String? ?? '',
      telephones:
          (json['telephones'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      whatsAppTelephone: json['whatsAppTelephone'] as String? ?? '',
      ratingCount: json['ratingCount'] as int? ?? 0,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      isActive: json['isActive'] as bool? ?? false,
      isAlwaysOpen: json['isAlwaysOpen'] as bool? ?? false,
      localizedName: json['localizedName'] as Map<String, dynamic>? ?? {},
      addressMap: json['address'] as Map<String, dynamic>? ?? {},
      city: json['city'] as Map<String, dynamic>? ?? {},
      provider: json['provider'] as Map<String, dynamic>? ?? {},
    );
  }

  // Getters for UI compatibility

  String get name {
    // Determine language, default to 'en' or first available
    // For now returning 'en' or 'ar' based on basic logic, or concatenating?
    // User response sample has "en" and "ar". Let's prefer 'en' for now or the first key.
    return localizedName['en'] ?? localizedName['ar'] ?? 'Pharmacy Name';
  }

  // Distance is not in the API response, so we return a placeholder or calculate if we had user location.
  // Returning empty or a static string for now as per "display only matched fetched data"

  void calculateDistance(AddressModel selectedAddress) {
    try {
      final Distance d = const Distance();
      final double m = d.as(
        LengthUnit.Meter,
        LatLng(selectedAddress.latitude, selectedAddress.longitude),
        LatLng(latitude, longitude),
      );

      // Check if distance is less than 1 km, display in meters
      if (m < 1000) {
        // Convert to meters
        final double meters = m;

        // If meters is less than 10, show one decimal place
        if (meters < 10) {
          distance = '${meters.toStringAsFixed(1)} m';
        } else {
          // Round to nearest whole number for larger meter values
          distance = '${meters.round()} m';
        }
      } else {
        final double km = m / 1000;
        // Display with one decimal place for km
        distance = '${km.toStringAsFixed(2)} Km';
      }
    } catch (e) {
      log('Error calculating distance: $e');
      distance = 'calculation error: $e';
    }
  } // or calculate if user location is known

  double get rating => ratingCount
      .toDouble(); // The API only gives ratingCount, assume it's the score or 0.

  String get workingHours => isAlwaysOpen
      ? '24 Hours'
      : 'Closed'; // Or format based on other data if available? API only has isAlwaysOpen.

  // Image is not in API.
  String get imageUrl =>
      'https://images.unsplash.com/photo-1596522016734-8e6136fe5cfa?w=600'; // Placeholder

  bool get isOpen =>
      isActive; // or isAlwaysOpen? isActive probably means the branch is operational.

  String? get address => addressMap['en'] ?? addressMap['ar'];

  String? get phone => telephones.isNotEmpty ? telephones.first : null;

  String get displayAddress => address ?? 'Address not available';

  String get displayPhone => phone ?? 'No phone number';

  int get totalDoctors => 0; // Not in API response
}
