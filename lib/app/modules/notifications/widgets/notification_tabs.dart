import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.05),
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
            context,
            label: 'notifications.all'.tr,
            count: allCount,
            isSelected: selectedTab == 'all',
            onTap: () => onTabChanged('all'),
          ),

          const SizedBox(width: 4),

          // Medicine tab
          _buildTab(
            context,
            label: 'notifications.medicine'.tr,
            count: medicineCount,
            isSelected: selectedTab == 'medicine',
            onTap: () => onTabChanged('medicine'),
          ),

          const SizedBox(width: 4),

          // Other tab
          _buildTab(
            context,
            label: 'notifications.other'.tr,
            count: otherCount,
            isSelected: selectedTab == 'other',
            onTap: () => onTabChanged('other'),
          ),
        ],
      ),
    );
  }

  // Build individual tab
  Widget _buildTab(
    BuildContext context, {
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
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '($count)',
                style: TextStyle(
                  fontSize: 11,
                  color: isSelected
                      ? Theme.of(context).colorScheme.onPrimary.withOpacity(0.8)
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
