import 'medicine_model.dart';

// Family member medicines model representing medicines for a family member
class FamilyMedicinesModel {
  final int id;
  final String name;
  final String relation; // "Self", "Mother", "Father", "Daughter", "Son"
  final String? imageUrl;
  final List<MedicineModel> medicines;

  FamilyMedicinesModel({
    required this.id,
    required this.name,
    required this.relation,
    this.imageUrl,
    required this.medicines,
  });

  // Get initials from name for avatar fallback
  String get initials {
    return name
        .split(' ')
        .map((word) => word.isNotEmpty ? word[0] : '')
        .join('')
        .toUpperCase();
  }

  // Get total medicines count
  int get medicinesCount => medicines.length;

  // Get total doses taken today
  int get totalTakenToday {
    return medicines.fold<int>(0, (sum, med) => sum + med.takenToday);
  }

  // Get total doses for today
  int get totalDosesToday {
    return medicines.fold<int>(0, (sum, med) => sum + med.totalToday);
  }

  // Get progress percentage for today
  double get progressPercentage {
    if (totalDosesToday == 0) return 0;
    return (totalTakenToday / totalDosesToday) * 100;
  }

  // Get next medicine to take
  MedicineModel? getNextMedicine() {
    final now = DateTime.now();
    final currentTime = now.hour * 60 + now.minute;

    MedicineModel? nextMedicine;
    int? nextTime;

    for (var medicine in medicines) {
      if (!medicine.reminderEnabled) continue;

      for (var timeStr in medicine.times) {
        final parts = timeStr.split(' ');
        final timeParts = parts[0].split(':');
        final period = parts[1];

        int hours = int.parse(timeParts[0]);
        final minutes = int.parse(timeParts[1]);

        // Convert to 24-hour format
        if (period == 'PM' && hours != 12) {
          hours += 12;
        } else if (period == 'AM' && hours == 12) {
          hours = 0;
        }

        final totalMinutes = hours * 60 + minutes;

        if (totalMinutes > currentTime) {
          if (nextTime == null || totalMinutes < nextTime) {
            nextTime = totalMinutes;
            nextMedicine = medicine;
          }
        }
      }
    }

    return nextMedicine;
  }

  // Create a copy with modified fields
  FamilyMedicinesModel copyWith({
    int? id,
    String? name,
    String? relation,
    String? imageUrl,
    List<MedicineModel>? medicines,
  }) {
    return FamilyMedicinesModel(
      id: id ?? this.id,
      name: name ?? this.name,
      relation: relation ?? this.relation,
      imageUrl: imageUrl ?? this.imageUrl,
      medicines: medicines ?? this.medicines,
    );
  }
}
