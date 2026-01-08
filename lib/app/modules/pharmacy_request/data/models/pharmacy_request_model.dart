class PharmacyRequest {
  final String requestNo;
  final ServiceRequestType type;
  final String status;
  final List<String> prescriptionImages;
  final List<ManualItem> manualItems;
  final String? notes;
  final DateTime expiresAt;
  final String userId;
  final String branchId;
  final RequestMetadata metadata;
  final String id;
  final DoctorInfo? doctor;

  PharmacyRequest({
    required this.requestNo,
    required this.type,
    required this.status,
    required this.prescriptionImages,
    required this.manualItems,
    this.notes,
    required this.expiresAt,
    required this.userId,
    required this.branchId,
    required this.metadata,
    required this.id,
    this.doctor,
  });

  factory PharmacyRequest.fromJson(Map<String, dynamic> json) {
    return PharmacyRequest(
      requestNo: json['requestNo'] as String,
      type: ServiceRequestType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => ServiceRequestType.PICKUP_ORDER,
      ),
      status: json['status'] as String,
      prescriptionImages: List<String>.from(json['prescriptionImages'] ?? []),
      manualItems:
          (json['manualItems'] as List<dynamic>?)
              ?.map((e) => ManualItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      notes: json['notes'] as String?,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      userId: json['userId'] as String,
      branchId: json['branchId'] as String,
      metadata: RequestMetadata.fromJson(
        json['metadata'] as Map<String, dynamic>,
      ),
      id: json['id'] as String,
      doctor: json['doctor'] != null
          ? DoctorInfo.fromJson(json['doctor'] as Map<String, dynamic>)
          : null,
    );
  }

  PharmacyRequest copyWith({
    String? requestNo,
    ServiceRequestType? type,
    String? status,
    List<String>? prescriptionImages,
    List<ManualItem>? manualItems,
    String? notes,
    DateTime? expiresAt,
    String? userId,
    String? branchId,
    RequestMetadata? metadata,
    String? id,
    DoctorInfo? doctor,
  }) {
    return PharmacyRequest(
      requestNo: requestNo ?? this.requestNo,
      type: type ?? this.type,
      status: status ?? this.status,
      prescriptionImages: prescriptionImages ?? this.prescriptionImages,
      manualItems: manualItems ?? this.manualItems,
      notes: notes ?? this.notes,
      expiresAt: expiresAt ?? this.expiresAt,
      userId: userId ?? this.userId,
      branchId: branchId ?? this.branchId,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      doctor: doctor ?? this.doctor,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requestNo': requestNo,
      'type': type.name,
      'status': status,
      'prescriptionImages': prescriptionImages,
      'manualItems': manualItems.map((e) => e.toJson()).toList(),
      'notes': notes,
      'expiresAt': expiresAt.toIso8601String(),
      'userId': userId,
      'branchId': branchId,
      'metadata': metadata.toJson(),
      'id': id,
      'doctor': doctor?.toJson(),
    };
  }
}

enum ServiceRequestType { DELEVARY_ORDER, PICKUP_ORDER, HOME_VISIT }

class ManualItem {
  final String medicineName;
  final int quantity;

  ManualItem({required this.medicineName, this.quantity = 1});

  factory ManualItem.fromJson(Map<String, dynamic> json) {
    return ManualItem(
      medicineName: json['medicineName'] as String,
      quantity: json['quantity'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {'medicineName': medicineName, 'quantity': quantity};
  }
}

class RequestMetadata {
  final DateTime updatedAt;
  final int version;
  final DateTime createdAt;

  RequestMetadata({
    required this.updatedAt,
    required this.version,
    required this.createdAt,
  });

  factory RequestMetadata.fromJson(Map<String, dynamic> json) {
    return RequestMetadata(
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      version: json['version'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'updatedAt': updatedAt.toIso8601String(),
      'version': version,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class DoctorInfo {
  final String id;
  final String firstName;
  final String lastName;

  DoctorInfo({required this.id, required this.firstName, required this.lastName});

  factory DoctorInfo.fromJson(Map<String, dynamic> json) {
    return DoctorInfo(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    );
  }

  String get fullName => "$firstName $lastName";

  Map<String, dynamic> toJson() {
    return {'id': id, 'firstName': firstName, 'lastName': lastName};
  }
}
