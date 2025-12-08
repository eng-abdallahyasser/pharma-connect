import 'package:flutter/material.dart';

class NavItemModel {
  final String id;
  final String label;
  final IconData icon;
  final String route;

  NavItemModel({
    required this.id,
    required this.label,
    required this.icon,
    required this.route,
  });
}
