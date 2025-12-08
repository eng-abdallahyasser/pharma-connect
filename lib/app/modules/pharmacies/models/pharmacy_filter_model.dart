class PharmacyFilterModel {
  final String id;
  final String label;
  final bool isActive;

  PharmacyFilterModel({
    required this.id,
    required this.label,
    this.isActive = false,
  });

  PharmacyFilterModel copyWith({
    String? id,
    String? label,
    bool? isActive,
  }) {
    return PharmacyFilterModel(
      id: id ?? this.id,
      label: label ?? this.label,
      isActive: isActive ?? this.isActive,
    );
  }
}
