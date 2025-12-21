import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Consultation tabs widget for switching between Available, Upcoming, and History
class ConsultationTabs extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabChanged;
  final int upcomingCount; // Badge count for upcoming tab

  const ConsultationTabs({
    super.key,
    required this.currentIndex,
    required this.onTabChanged,
    this.upcomingCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // White background with shadow
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          // Available tab
          Expanded(
            child: _buildTab(
              label: 'consultations.available'.tr,
              isActive: currentIndex == 0,
              onTap: () => onTabChanged(0),
            ),
          ),

          // Upcoming tab with badge
          Expanded(
            child: Stack(
              children: [
                _buildTab(
                  label: 'consultations.upcoming'.tr,
                  isActive: currentIndex == 1,
                  onTap: () => onTabChanged(1),
                ),

                // Badge for upcoming count
                if (upcomingCount > 0) _buildTabNotifier(upcomingCount),
              ],
            ),
          ),

          // History tab
          Expanded(
            child: _buildTab(
              label: 'consultations.history'.tr,
              isActive: currentIndex == 2,
              onTap: () => onTabChanged(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabNotifier(int count) {
    return Positioned(
      top: 4,
      right: 4,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: const Color(0xFFEF4444),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // Build individual tab button
  Widget _buildTab({
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF1A73E8) : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }
}
