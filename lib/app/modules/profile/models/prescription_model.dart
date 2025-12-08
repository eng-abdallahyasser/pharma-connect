// Prescription model representing a medical prescription
class PrescriptionModel {
  final int id;
  final String doctorName;
  final String date;
  final String diagnosis;
  final List<String> medicines;
  final String status; // "Active" or "Completed"

  PrescriptionModel({
    required this.id,
    required this.doctorName,
    required this.date,
    required this.diagnosis,
    required this.medicines,
    required this.status,
  });

  // Check if prescription is active
  bool get isActive => status == "Active";

  // Create a copy with modified fields
  PrescriptionModel copyWith({
    int? id,
    String? doctorName,
    String? date,
    String? diagnosis,
    List<String>? medicines,
    String? status,
  }) {
    return PrescriptionModel(
      id: id ?? this.id,
      doctorName: doctorName ?? this.doctorName,
      date: date ?? this.date,
      diagnosis: diagnosis ?? this.diagnosis,
      medicines: medicines ?? this.medicines,
      status: status ?? this.status,
    );
  }
}
