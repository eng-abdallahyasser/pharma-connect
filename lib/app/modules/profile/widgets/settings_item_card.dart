import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/menu_item_model.dart';

// Settings item card widget for settings menu items
class SettingsItemCard extends StatelessWidget {
  final SettingsItemModel item;
  final bool isLast; // Whether this is the last item in the list
  final ValueChanged<bool>? onToggleChanged; // Callback for toggle changes
  final RxBool? darkModeEnabled; // Observable for dark mode state
  final RxBool? notificationsEnabled; // Observable for notifications state

  const SettingsItemCard({
    super.key,
    required this.item,
    this.isLast = false,
    this.onToggleChanged,
    this.darkModeEnabled,
    this.notificationsEnabled,
  });

  bool _getInitialToggleValue() {
    if (item.id == 'darkmode' && darkModeEnabled != null) {
      return darkModeEnabled!.value;
    } else if (item.id == 'notifications' && notificationsEnabled != null) {
      return notificationsEnabled!.value;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !item.hasToggle ? item.onTap : null,
      child: Container(
        // Add border only if not the last item
        decoration: BoxDecoration(
          border: !isLast
              ? Border(bottom: BorderSide(color: Theme.of(context).dividerColor, width: 1))
              : null,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Icon
            Icon(item.icon, color: Theme.of(context).hintColor, size: 20),
            const SizedBox(width: 16),

            // Label
            Expanded(
              child: Text(
                item.label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ),

            // Right side content (toggle, value, or chevron)
            if (item.hasToggle)
              // Toggle switch with Obx for reactivity
              Obx(() {
                bool toggleValue = _getInitialToggleValue();
                return GestureDetector(
                  onTap: () {
                    item.onTap?.call();
                    onToggleChanged?.call(!toggleValue);
                  },
                  child: Container(
                    width: 48,
                    height: 28,
                    decoration: BoxDecoration(
                      color: toggleValue
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).dividerColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Stack(
                      children: [
                        // Animated toggle indicator
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 200),
                          left: toggleValue ? 24 : 2,
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
                );
              })
            else if (item.value != null)
              // Display value text
              Row(
                children: [
                  Text(
                    item.value!,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
                ],
              )
            else
              // Chevron icon
              Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
          ],
        ),
      ),
    );
  }
}
