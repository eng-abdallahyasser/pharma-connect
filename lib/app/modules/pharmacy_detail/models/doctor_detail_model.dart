// Doctor detail model representing a doctor at a pharmacy
class DoctorDetailModel {
  final int id;
  final String name;
  final String specialization;
  final String photo;
  final String workingHours;
  final double rating;
  final String experience;
  final String consultationFee;
  final bool isAvailable;

  DoctorDetailModel({
    required this.id,
    required this.name,
    required this.specialization,
    required this.photo,
    required this.workingHours,
    required this.rating,
    required this.experience,
    required this.consultationFee,
    required this.isAvailable,
  });

  // Get doctor initials for avatar fallback
  String get initials {
    return name
        .split(' ')
        .map((word) => word.isNotEmpty ? word[0] : '')
        .join('')
        .toUpperCase();
  }

  // Get availability status text
  String get availabilityStatus => isAvailable ? 'Available' : 'Busy';

  // Create a copy with modified fields
  DoctorDetailModel copyWith({
    int? id,
    String? name,
    String? specialization,
    String? photo,
    String? workingHours,
    double? rating,
    String? experience,
    String? consultationFee,
    bool? isAvailable,
  }) {
    return DoctorDetailModel(
      id: id ?? this.id,
      name: name ?? this.name,
      specialization: specialization ?? this.specialization,
      photo: photo ?? this.photo,
      workingHours: workingHours ?? this.workingHours,
      rating: rating ?? this.rating,
      experience: experience ?? this.experience,
      consultationFee: consultationFee ?? this.consultationFee,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}
