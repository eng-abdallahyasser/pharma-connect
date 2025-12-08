// Doctor model representing a healthcare professional
class DoctorModel {
  final int id;
  final String name;
  final String specialization;
  final String imageUrl;
  final double rating;
  final String status; // "available", "busy", "offline"

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialization,
    required this.imageUrl,
    required this.rating,
    required this.status,
  });

  // Get initials from doctor's name for avatar fallback
  String get initials {
    return name
        .split(' ')
        .map((word) => word.isNotEmpty ? word[0] : '')
        .join('')
        .toUpperCase();
  }

  // Check if doctor is available for consultation
  bool get isAvailable => status == "available";

  // Check if doctor is offline
  bool get isOffline => status == "offline";

  // Create a copy with modified fields
  DoctorModel copyWith({
    int? id,
    String? name,
    String? specialization,
    String? imageUrl,
    double? rating,
    String? status,
  }) {
    return DoctorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      specialization: specialization ?? this.specialization,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      status: status ?? this.status,
    );
  }
}
