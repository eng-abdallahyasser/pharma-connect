import 'package:flutter/material.dart';
import '../models/menu_item_model.dart';

// Settings item card widget for settings menu items
class SettingsItemCard extends StatefulWidget {
  final SettingsItemModel item;
  final bool isLast; // Whether this is the last item in the list
  final ValueChanged<bool>? onToggleChanged; // Callback for toggle changes

  const SettingsItemCard({
    Key? key,
    required this.item,
    this.isLast = false,
    this.onToggleChanged,
  }) : super(key: key);

  @override
  State<SettingsItemCard> createState() => _SettingsItemCardState();
}

class _SettingsItemCardState extends State<SettingsItemCard> {
  // Local state for toggle switch
  late bool toggleValue;

  @override
  void initState() {
    super.initState();
    // Initialize toggle value (default to false)
    toggleValue = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !widget.item.hasToggle ? widget.item.onTap : null,
      child: Container(
        // Add border only if not the last item
        decoration: BoxDecoration(
          border: !widget.isLast
              ? Border(
                  bottom: BorderSide(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                )
              : null,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Icon
            Icon(
              widget.item.icon,
              color: Colors.grey[600],
              size: 20,
            ),
            const SizedBox(width: 16),

            // Label
            Expanded(
              child: Text(
                widget.item.label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1F2937),
                ),
              ),
            ),

            // Right side content (toggle, value, or chevron)
            if (widget.item.hasToggle)
              // Toggle switch
              GestureDetector(
                onTap: () {
                  setState(() {
                    toggleValue = !toggleValue;
                  });
                  widget.onToggleChanged?.call(toggleValue);
                  widget.item.onTap?.call();
                },
                child: Container(
                  width: 48,
                  height: 28,
                  decoration: BoxDecoration(
                    color: toggleValue
                        ? const Color(0xFF1A73E8)
                        : Colors.grey[300],
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
              )
            else if (widget.item.value != null)
              // Display value text
              Row(
                children: [
                  Text(
                    widget.item.value!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                    size: 20,
                  ),
                ],
              )
            else
              // Chevron icon
              Icon(
                Icons.chevron_right,
                color: Colors.grey[400],
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
