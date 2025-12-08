// Family member model representing a family member's profile
class FamilyMemberModel {
  final int id;
  final String name;
  final String relation; // "Mother", "Father", "Daughter", "Son", etc.
  final int age;
  final String bloodType;
  final String imageUrl;
  final List<String> conditions; // Medical conditions

  FamilyMemberModel({
    required this.id,
    required this.name,
    required this.relation,
    required this.age,
    required this.bloodType,
    required this.imageUrl,
    required this.conditions,
  });

  // Get initials from name for avatar fallback
  String get initials {
    return name
        .split(' ')
        .map((word) => word.isNotEmpty ? word[0] : '')
        .join('')
        .toUpperCase();
  }

  // Create a copy with modified fields
  FamilyMemberModel copyWith({
    int? id,
    String? name,
    String? relation,
    int? age,
    String? bloodType,
    String? imageUrl,
    List<String>? conditions,
  }) {
    return FamilyMemberModel(
      id: id ?? this.id,
      name: name ?? this.name,
      relation: relation ?? this.relation,
      age: age ?? this.age,
      bloodType: bloodType ?? this.bloodType,
      imageUrl: imageUrl ?? this.imageUrl,
      conditions: conditions ?? this.conditions,
    );
  }
}
