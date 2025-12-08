import 'package:flutter/material.dart';
import '../models/medicine_model.dart';

// Next reminder banner widget showing upcoming medicine reminder
class NextReminderBanner extends StatelessWidget {
  final String memberName;
  final MedicineModel? nextMedicine;

  const NextReminderBanner({
    Key? key,
    required this.memberName,
    required this.nextMedicine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (nextMedicine == null) {
      return const SizedBox.shrink();
    }

    return Container(
      // Semi-transparent blue background
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Bell icon with green background
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF00C897),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.notifications,
              color: Colors.white,
              size: 24,
            ),
          ),

          const SizedBox(width: 12),

          // Medicine info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Label
                Text(
                  'Next Reminder for $memberName',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),

                const SizedBox(height: 4),

                // Medicine name and time
                Text(
                  '${nextMedicine!.name} at ${nextMedicine!.times.first}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Clock icon
          Icon(
            Icons.schedule,
            color: Colors.white.withOpacity(0.9),
            size: 20,
          ),
        ],
      ),
    );
  }
}
