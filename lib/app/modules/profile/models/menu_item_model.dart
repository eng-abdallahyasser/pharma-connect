import 'package:flutter/material.dart';

// Menu item model for profile menu items
class MenuItemModel {
  final String id;
  final String label;
  final String description;
  final IconData icon;
  final Color iconColor;
  final int? badge; // Optional badge count
  final VoidCallback onTap;

  MenuItemModel({
    required this.id,
    required this.label,
    required this.description,
    required this.icon,
    required this.iconColor,
    this.badge,
    required this.onTap,
  });
}

// Settings item model for settings menu items
class SettingsItemModel {
  final String id;
  final String label;
  final IconData icon;
  final bool hasToggle; // Whether to show a toggle switch
  final String? value; // Optional value to display (e.g., "English")
  final VoidCallback? onTap;

  SettingsItemModel({
    required this.id,
    required this.label,
    required this.icon,
    this.hasToggle = false,
    this.value,
    this.onTap,
  });
}
