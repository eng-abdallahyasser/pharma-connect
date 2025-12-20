class AddressModel {
  final String id;
  final String label;
  final String fullAddress;
  final double latitude;
  final double longitude;
  final bool isSelected;

  AddressModel({
    required this.id,
    required this.label,
    required this.fullAddress,
    required this.latitude,
    required this.longitude,
    this.isSelected = false,
  });

  AddressModel copyWith({
    String? id,
    String? label,
    String? fullAddress,
    double? latitude,
    double? longitude,
    bool? isSelected,
  }) {
    return AddressModel(
      id: id ?? this.id,
      label: label ?? this.label,
      fullAddress: fullAddress ?? this.fullAddress,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'fullAddress': fullAddress,
      'latitude': latitude,
      'longitude': longitude,
      'isSelected': isSelected,
    };
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      label: json['label'],
      fullAddress: json['fullAddress'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      isSelected: json['isSelected'] ?? false,
    );
  }
}
