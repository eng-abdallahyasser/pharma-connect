// User model representing the current user's profile information
class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String imageUrl;
  final String bloodType;
  final List<String> allergies;
  final List<String> chronicConditions;
  final String insuranceProvider;
  final String insuranceNumber;
  final EmergencyContact emergencyContact;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.imageUrl,
    required this.bloodType,
    required this.allergies,
    required this.chronicConditions,
    required this.insuranceProvider,
    required this.insuranceNumber,
    required this.emergencyContact,
  });

  // Create a copy of this model with modified fields
  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? imageUrl,
    String? bloodType,
    List<String>? allergies,
    List<String>? chronicConditions,
    String? insuranceProvider,
    String? insuranceNumber,
    EmergencyContact? emergencyContact,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      imageUrl: imageUrl ?? this.imageUrl,
      bloodType: bloodType ?? this.bloodType,
      allergies: allergies ?? this.allergies,
      chronicConditions: chronicConditions ?? this.chronicConditions,
      insuranceProvider: insuranceProvider ?? this.insuranceProvider,
      insuranceNumber: insuranceNumber ?? this.insuranceNumber,
      emergencyContact: emergencyContact ?? this.emergencyContact,
    );
  }
}

// Emergency contact information model
class EmergencyContact {
  final String name;
  final String relation;
  final String phone;

  EmergencyContact({
    required this.name,
    required this.relation,
    required this.phone,
  });
}
