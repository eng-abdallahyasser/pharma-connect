// Branch model for doctor's location
class Branch {
  final String id;
  final double latitude;
  final double longitude;
  final Provider provider;
  final City city;

  Branch({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.provider,
    required this.city,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'] ?? '',
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
      provider: Provider.fromJson(json['provider'] ?? {}),
      city: City.fromJson(json['city'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'provider': provider.toJson(),
      'city': city.toJson(),
    };
  }
}

// Provider model
class Provider {
  final String id;

  Provider({required this.id});

  factory Provider.fromJson(Map<String, dynamic> json) {
    return Provider(id: json['id'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}

// City model
class City {
  final String id;

  City({required this.id});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(id: json['id'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}

// Doctor model representing a healthcare professional
class DoctorModel {
  final String id;
  final String firstName;
  final String lastName;
  final String gender;
  final bool isOnline;
  final Branch branch;
  final double distance;
  final double averageRating;
  final int totalRaters;

  // Legacy fields for backward compatibility with existing UI
  final String? specialization;
  final String? imageUrl;

  DoctorModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.isOnline,
    required this.branch,
    required this.distance,
    this.averageRating = 0.0,
    this.totalRaters = 0,
    this.specialization,
    this.imageUrl,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    // Parse averageRating - it comes as a string from API
    double avgRating = 0.0;
    if (json['averageRating'] != null) {
      if (json['averageRating'] is String) {
        avgRating = double.tryParse(json['averageRating']) ?? 0.0;
      } else {
        avgRating = (json['averageRating'] as num).toDouble();
      }
    }

    return DoctorModel(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      gender: json['gender'] ?? 'male',
      isOnline: json['isOnline'] ?? false,
      branch: Branch.fromJson(json['branch'] ?? {}),
      distance: (json['distance'] ?? 0).toDouble(),
      averageRating: avgRating,
      totalRaters: json['totalRaters'] ?? 0,
      specialization: json['specialization'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'isOnline': isOnline,
      'branch': branch.toJson(),
      'distance': distance,
      'averageRating': averageRating.toString(),
      'totalRaters': totalRaters,
      if (specialization != null) 'specialization': specialization,
      if (imageUrl != null) 'imageUrl': imageUrl,
    };
  }

  // Rating getter for backward compatibility with UI
  double? get rating => averageRating;

  // Get full name
  String get name => '$firstName $lastName';

  // Get initials from doctor's name for avatar fallback
  String get initials {
    final first = firstName.isNotEmpty ? firstName[0] : '';
    final last = lastName.isNotEmpty ? lastName[0] : '';
    return '$first$last'.toUpperCase();
  }

  // Check if doctor is available for consultation (online doctors are available)
  bool get isAvailable => isOnline;

  // Check if doctor is offline
  bool get isOffline => !isOnline;

  // Get status string for UI compatibility
  String get status => isOnline ? 'available' : 'offline';

  // Create a copy with modified fields
  DoctorModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? gender,
    bool? isOnline,
    Branch? branch,
    double? distance,
    double? averageRating,
    int? totalRaters,
    String? specialization,
    String? imageUrl,
  }) {
    return DoctorModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      isOnline: isOnline ?? this.isOnline,
      branch: branch ?? this.branch,
      distance: distance ?? this.distance,
      averageRating: averageRating ?? this.averageRating,
      totalRaters: totalRaters ?? this.totalRaters,
      specialization: specialization ?? this.specialization,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
