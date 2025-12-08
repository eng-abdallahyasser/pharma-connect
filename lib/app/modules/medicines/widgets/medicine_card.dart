import 'package:flutter/material.dart';
import '../models/medicine_model.dart';

// Medicine card widget displaying medicine details and progress
class MedicineCard extends StatelessWidget {
  final MedicineModel medicine;
  final VoidCallback onTap;
  final VoidCallback onReminderToggle;
  final VoidCallback? onMarkAsTaken;

  const MedicineCard({
    Key? key,
    required this.medicine,
    required this.onTap,
    required this.onReminderToggle,
    this.onMarkAsTaken,
  }) : super(key: key);

  // Convert hex color to Flutter Color
  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceFirst('#', '');
    return Color(int.parse('FF$hexColor', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    final medicineColor = _getColorFromHex(medicine.color);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        // White card with rounded corners and shadow
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon, name, and reminder toggle
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Medicine icon with color background
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: medicineColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.medication,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),

                // Medicine name and dosage
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Medicine name
                      Text(
                        medicine.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Dosage and frequency
                      Text(
                        '${medicine.dosage} • ${medicine.frequency}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                // Reminder toggle
                GestureDetector(
                  onTap: onReminderToggle,
                  child: Container(
                    width: 48,
                    height: 28,
                    decoration: BoxDecoration(
                      color: medicine.reminderEnabled
                          ? const Color(0xFF1A73E8)
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Stack(
                      children: [
                        // Toggle indicator
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 200),
                          left: medicine.reminderEnabled ? 24 : 2,
                          top: 2,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Instructions if available
            if (medicine.instructions != null) ...[
              Text(
                '📝 ${medicine.instructions}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Progress bar
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: medicine.progressPercentage / 100,
                        backgroundColor: Colors.transparent,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(medicineColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Progress text
                Text(
                  '${medicine.takenToday}/${medicine.totalToday}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Time badges
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: medicine.times.asMap().entries.map((entry) {
                final index = entry.key;
                final time = entry.value;
                final isTaken = index < medicine.takenToday;

                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isTaken
                        ? medicineColor.withOpacity(0.2)
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 12,
                        color: isTaken ? medicineColor : Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 11,
                          color: isTaken ? medicineColor : Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 12),

            // Duration info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      medicine.startDate,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                    ),
                    if (medicine.endDate != null) ...[
                      const SizedBox(width: 4),
                      Text(
                        '- ${medicine.endDate}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ],
                ),

                // Details link
                Row(
                  children: [
                    Text(
                      'Details',
                      style: TextStyle(
                        fontSize: 11,
                        color: const Color(0xFF1A73E8),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right,
                      size: 14,
                      color: const Color(0xFF1A73E8),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
