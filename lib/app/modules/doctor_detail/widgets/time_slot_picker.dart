import 'package:flutter/material.dart';

// Time slot picker widget for selecting appointment time
class TimeSlotPicker extends StatelessWidget {
  final List<String> timeSlots;
  final String? selectedSlot;
  final Function(String) onSlotSelected;

  const TimeSlotPicker({
    super.key,
    required this.timeSlots,
    required this.selectedSlot,
    required this.onSlotSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.access_time_rounded,
                size: 18,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Available Time Slots',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Time slots grid
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: timeSlots.map((slot) {
            final isSelected = selectedSlot == slot;

            return GestureDetector(
              onTap: () => onSlotSelected(slot),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Theme.of(context).colorScheme.secondary,
                            Theme.of(
                              context,
                            ).colorScheme.secondary.withOpacity(0.8),
                          ],
                        )
                      : null,
                  color: isSelected
                      ? null
                      : Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSelected ? Colors.transparent : Colors.grey[300]!,
                    width: 1,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).colorScheme.secondary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected) ...[
                      const Icon(
                        Icons.check_circle,
                        size: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 6),
                    ],
                    Text(
                      slot,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),

        // Empty state
        if (timeSlots.isEmpty)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.event_busy, size: 40, color: Colors.grey[400]),
                  const SizedBox(height: 12),
                  Text(
                    'No available slots',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Please select a different date',
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
