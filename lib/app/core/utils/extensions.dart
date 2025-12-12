import 'package:flutter/material.dart';

class AppExtensions {
  /// Context extensions (use with Get context)
  static MediaQueryData? getMediaQuery(BuildContext context) {
    return MediaQuery.of(context);
  }
}

/// Extension on String
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String capitalizeByWord() {
    return split(" ").map((str) => str.capitalize()).join(" ");
  }

  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  bool get isValidPhone {
    final phoneRegex = RegExp(
      r'^[+]?[(]?[0-9]{3}[)]?[-\s.]?[0-9]{3}[-\s.]?[0-9]{4,6}$',
    );
    return phoneRegex.hasMatch(this);
  }

  bool get isNotEmpty => trim().isNotEmpty;
}

/// Extension on double
extension DoubleExtension on double {
  bool isBetween(double min, double max) {
    return this >= min && this <= max;
  }
}

/// Extension on int
extension IntExtension on int {
  bool isBetween(int min, int max) {
    return this >= min && this <= max;
  }
}
