import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/medicine_model.dart';

// Next reminder banner widget showing upcoming medicine reminder
class NextReminderBanner extends StatelessWidget {
  final String memberName;
  final MedicineModel? nextMedicine;

  const NextReminderBanner({
    super.key,
    required this.memberName,
    required this.nextMedicine,
  });

  @override
  Widget build(BuildContext context) {
    if (nextMedicine == null) {
      return const SizedBox.shrink();
    }

    return Container(
      // Semi-transparent blue background
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary.withAlpha(38),
        borderRadius: BorderRadius.circular(24),
        // border: Border.all(
        //   color: Colors.white.withAlpha(51),
        //   width: 1,
        // ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Bell icon with green background
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.notifications,
              color: Theme.of(context).colorScheme.onSecondary,
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
                  'medicines.next_reminder'.trParams({'name': memberName}),
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(
                      context,
                    ).colorScheme.onPrimary.withAlpha(230),
                  ),
                ),

                const SizedBox(height: 4),

                // Medicine name and time
                Text(
                  '${nextMedicine!.name} at ${nextMedicine!.times.first}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),

          // Clock icon
          Icon(
            Icons.schedule,
            color: Theme.of(context).colorScheme.onPrimary.withAlpha(230),
            size: 20,
          ),
        ],
      ),
    );
  }
}
