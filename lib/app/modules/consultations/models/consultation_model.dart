// Consultation model representing a scheduled consultation
class ConsultationModel {
  final int id;
  final String doctorName;
  final String specialization;
  final String date;
  final String time;
  final String type; // "Video Call", "Chat", "Phone Call"
  final String status; // "confirmed", "pending", "completed"
  final bool hasPrescription; // Whether consultation has a prescription

  ConsultationModel({
    required this.id,
    required this.doctorName,
    required this.specialization,
    required this.date,
    required this.time,
    required this.type,
    required this.status,
    this.hasPrescription = false,
  });

  // Check if consultation is confirmed
  bool get isConfirmed => status == "confirmed";

  // Check if consultation is pending
  bool get isPending => status == "pending";

  // Check if consultation is completed
  bool get isCompleted => status == "completed";

  // Check if consultation is video call
  bool get isVideoCall => type == "Video Call";

  // Check if consultation is chat
  bool get isChat => type == "Chat";

  // Create a copy with modified fields
  ConsultationModel copyWith({
    int? id,
    String? doctorName,
    String? specialization,
    String? date,
    String? time,
    String? type,
    String? status,
    bool? hasPrescription,
  }) {
    return ConsultationModel(
      id: id ?? this.id,
      doctorName: doctorName ?? this.doctorName,
      specialization: specialization ?? this.specialization,
      date: date ?? this.date,
      time: time ?? this.time,
      type: type ?? this.type,
      status: status ?? this.status,
      hasPrescription: hasPrescription ?? this.hasPrescription,
    );
  }
}
