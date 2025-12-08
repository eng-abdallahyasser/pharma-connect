// Pharmacy detail model representing detailed pharmacy information
class PharmacyDetailModel {
  final int id;
  final String name;
  final String distance;
  final double rating;
  final String workingHours;
  final String imageUrl;
  final bool isOpen;
  final String? address;
  final String? phone;
  final int totalDoctors;

  PharmacyDetailModel({
    required this.id,
    required this.name,
    required this.distance,
    required this.rating,
    required this.workingHours,
    required this.imageUrl,
    required this.isOpen,
    this.address,
    this.phone,
    this.totalDoctors = 0,
  });

  // Get default address if not provided
  String get displayAddress => address ?? '123 Main Street, Downtown, City';

  // Get default phone if not provided
  String get displayPhone => phone ?? '+1 (555) 123-4567';

  // Create a copy with modified fields
  PharmacyDetailModel copyWith({
    int? id,
    String? name,
    String? distance,
    double? rating,
    String? workingHours,
    String? imageUrl,
    bool? isOpen,
    String? address,
    String? phone,
    int? totalDoctors,
  }) {
    return PharmacyDetailModel(
      id: id ?? this.id,
      name: name ?? this.name,
      distance: distance ?? this.distance,
      rating: rating ?? this.rating,
      workingHours: workingHours ?? this.workingHours,
      imageUrl: imageUrl ?? this.imageUrl,
      isOpen: isOpen ?? this.isOpen,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      totalDoctors: totalDoctors ?? this.totalDoctors,
    );
  }
}
