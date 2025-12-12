import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Progress card widget displaying daily medicine progress
class ProgressCard extends StatelessWidget {
  final String memberName;
  final int takenToday;
  final int totalToday;
  final double progressPercentage;

  const ProgressCard({
    super.key,
    required this.memberName,
    required this.takenToday,
    required this.totalToday,
    required this.progressPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // White card with rounded corners and shadow
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Title
              Text(
                'medicines.progress_today'.trParams({'name': memberName}),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
              ),

              // Progress badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A73E8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$takenToday / $totalToday',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Progress bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress bar container
              Container(
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: progressPercentage / 100,
                    backgroundColor: Colors.transparent,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF00C897),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Progress percentage text
              Text(
                '${progressPercentage.toStringAsFixed(0)}${'medicines.complete'.tr}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
