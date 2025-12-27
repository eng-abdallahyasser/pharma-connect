// Family member model representing a family member's profile
class FamilyMemberModel {
  final String? id;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String? fullName;
  final String? birthDate;
  final String? gender;
  final String? relationship;
  final String? mobile;
  final String? email;
  final String? photoUrl;
  final bool? mobileVerified;
  final bool? emailVerified;
  final bool? isFamilyManager;
  final bool? isPrincipal;
  final bool? isMedicalProfileCompleted;

  FamilyMemberModel({
    this.id,
    required this.firstName,
    this.middleName,
    required this.lastName,
    this.fullName,
    this.birthDate,
    this.gender,
    this.relationship,
    this.mobile,
    this.email,
    this.photoUrl,
    this.mobileVerified,
    this.emailVerified,
    this.isFamilyManager,
    this.isPrincipal,
    this.isMedicalProfileCompleted,
  });

  factory FamilyMemberModel.fromJson(Map<String, dynamic> json) {
    return FamilyMemberModel(
      id: json['id'],
      firstName: json['firstName'] ?? '',
      middleName: json['middleName'],
      lastName: json['lastName'] ?? '',
      fullName: json['fullName'],
      birthDate: json['birthDate'],
      gender: json['gender'],
      relationship: json['relationship'],
      mobile: json['mobile'],
      email: json['email'],
      photoUrl: json['photoUrl'],
      mobileVerified: json['mobileVerified'],
      emailVerified: json['emailVerified'],
      isFamilyManager: json['isFamilyManager'],
      isPrincipal: json['is_principal'],
      isMedicalProfileCompleted: json['isMedicalProfileCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'firstName': firstName,
      'lastName': lastName,
    };

    if (middleName != null) data['middleName'] = middleName;
    if (birthDate != null) data['birthDate'] = birthDate;
    if (gender != null) data['gender'] = gender;
    if (relationship != null) data['relationship'] = relationship;
    if (mobile != null) data['mobile'] = mobile;
    if (email != null) data['email'] = email;
    if (photoUrl != null) data['photoUrl'] = photoUrl;

    return data;
  }

  // Helper getters
  String get displayName => fullName ?? '$firstName $lastName'.trim();

  String get initials {
    if (displayName.isEmpty) return '';
    final parts = displayName.trim().split(' ');
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
  }
}
