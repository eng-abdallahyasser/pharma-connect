import 'package:flutter/material.dart';

// Notification tabs widget for filtering notifications
class NotificationTabs extends StatelessWidget {
  final String selectedTab;
  final int allCount;
  final int medicineCount;
  final int otherCount;
  final ValueChanged<String> onTabChanged;

  const NotificationTabs({
    Key? key,
    required this.selectedTab,
    required this.allCount,
    required this.medicineCount,
    required this.otherCount,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // White background with rounded corners
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
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          // All tab
          _buildTab(
            label: 'All',
            count: allCount,
            isSelected: selectedTab == 'all',
            onTap: () => onTabChanged('all'),
          ),

          const SizedBox(width: 4),

          // Medicine tab
          _buildTab(
            label: 'Medicine',
            count: medicineCount,
            isSelected: selectedTab == 'medicine',
            onTap: () => onTabChanged('medicine'),
          ),

          const SizedBox(width: 4),

          // Other tab
          _buildTab(
            label: 'Other',
            count: otherCount,
            isSelected: selectedTab == 'other',
            onTap: () => onTabChanged('other'),
          ),
        ],
      ),
    );
  }

  // Build individual tab
  Widget _buildTab({
    required String label,
    required int count,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF1A73E8) : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : Colors.grey[600],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '($count)',
                style: TextStyle(
                  fontSize: 11,
                  color: isSelected
                      ? Colors.white.withOpacity(0.8)
                      : Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
