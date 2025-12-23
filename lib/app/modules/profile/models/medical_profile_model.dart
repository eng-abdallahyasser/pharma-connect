class MedicalProfile {
  final String id;
  final String userId;
  final String bloodType;
  final List<String> allergies;
  final List<String> chronicConditions;
  final List<String> currentMedications;
  final num height;
  final num weight;
  final String insuranceProvider;
  final String insurancePolicyNumber;
  final String notes;
  final MedicalProfileMetadata metadata;

  MedicalProfile({
    required this.id,
    required this.userId,
    required this.bloodType,
    required this.allergies,
    required this.chronicConditions,
    required this.currentMedications,
    required this.height,
    required this.weight,
    required this.insuranceProvider,
    required this.insurancePolicyNumber,
    required this.notes,
    required this.metadata,
  });

  factory MedicalProfile.fromJson(Map<String, dynamic> json) {
    return MedicalProfile(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      bloodType: json['bloodType'] ?? '',
      allergies: List<String>.from(json['allergies'] ?? []),
      chronicConditions: List<String>.from(json['chronicConditions'] ?? []),
      currentMedications: List<String>.from(json['currentMedications'] ?? []),
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      insuranceProvider: json['insuranceProvider'] ?? '',
      insurancePolicyNumber: json['insurancePolicyNumber'] ?? '',
      notes: json['notes'] ?? '',
      metadata: MedicalProfileMetadata.fromJson(json['metadata'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bloodType': bloodType,
      'allergies': allergies,
      'chronicConditions': chronicConditions,
      'currentMedications': currentMedications,
      'height': height,
      'weight': weight,
      'insuranceProvider': insuranceProvider,
      'insurancePolicyNumber': insurancePolicyNumber,
      'notes': notes,
    };
  }
}

class MedicalProfileMetadata {
  final String createdAt;
  final int version;

  MedicalProfileMetadata({required this.createdAt, required this.version});

  factory MedicalProfileMetadata.fromJson(Map<String, dynamic> json) {
    return MedicalProfileMetadata(
      createdAt: json['createdAt'] ?? '',
      version: json['version'] ?? 0,
    );
  }
}
