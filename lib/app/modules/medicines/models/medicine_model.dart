// Medicine model representing a medication with dosage and schedule
class MedicineModel {
  final int id;
  final String name;
  final String dosage;
  final String frequency; // "Once Daily", "Twice Daily", etc.
  final List<String> times; // ["08:00 AM", "08:00 PM"]
  final String color; // Hex color code for the medicine
  final bool reminderEnabled;
  final int takenToday;
  final int totalToday;
  final String? instructions;
  final String startDate;
  final String? endDate;

  MedicineModel({
    required this.id,
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.times,
    required this.color,
    required this.reminderEnabled,
    required this.takenToday,
    required this.totalToday,
    this.instructions,
    required this.startDate,
    this.endDate,
  });

  // Get progress percentage (0-100)
  double get progressPercentage {
    if (totalToday == 0) return 0;
    return (takenToday / totalToday) * 100;
  }

  // Check if all doses taken today
  bool get allTakenToday => takenToday >= totalToday;

  // Check if medicine has ended
  bool get hasEnded => endDate != null;

  // Create a copy with modified fields
  MedicineModel copyWith({
    int? id,
    String? name,
    String? dosage,
    String? frequency,
    List<String>? times,
    String? color,
    bool? reminderEnabled,
    int? takenToday,
    int? totalToday,
    String? instructions,
    String? startDate,
    String? endDate,
  }) {
    return MedicineModel(
      id: id ?? this.id,
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
      times: times ?? this.times,
      color: color ?? this.color,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      takenToday: takenToday ?? this.takenToday,
      totalToday: totalToday ?? this.totalToday,
      instructions: instructions ?? this.instructions,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
