import 'package:pharma_connect/app/locales/translations.dart';

class AuthValidators {
  // Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return getTranslation('auth.email.required');
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return getTranslation('auth.email.invalid');
    }

    return null;
  }

  // Password validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return getTranslation('auth.password.required');
    }

    if (value.length < 8) {
      return getTranslation('auth.password.min_length');
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return getTranslation('auth.password.uppercase');
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return getTranslation('auth.password.digit');
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return getTranslation('auth.password.special.char');
    }

    return null;
  }

  // Confirm password validation
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return getTranslation('auth.password.required');
    }

    if (value != password) {
      return getTranslation('auth.password.mismatch');
    }

    return null;
  }

  // Phone number validation
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return getTranslation('auth.phone.required');
    }

    final phoneRegex = RegExp(
      r'^[+]?[(]?[0-9]{3}[)]?[-\s.]?[0-9]{3}[-\s.]?[0-9]{4,6}$',
    );

    if (!phoneRegex.hasMatch(value)) {
      return getTranslation('auth.phone.invalid');
    }

    return null;
  }

  // First name validation
  static String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return getTranslation('auth.first.name.required');
    }

    if (value.length < 2) {
      return getTranslation('auth.first.name.min_length');
    }

    return null;
  }

  // Middle name validation
  static String? validateMiddleName(String? value) {
    if (value == null || value.isEmpty) {
      return getTranslation('auth.middle.name.required');
    }

    if (value.length < 2) {
      return getTranslation('auth.middle.name.min_length');
    }

    return null;
  }

  // Last name validation
  static String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return getTranslation('auth.last.name.required');
    }

    if (value.length < 2) {
      return getTranslation('auth.last.name.min_length');
    }

    return null;
  }

  // Terms acceptance validation
  static String? validateTermsAccepted(bool? value) {
    if (value != true) {
      return getTranslation('auth.terms.required');
    }

    return null;
  }

  // National ID validation (14 digits)
  static String? validateNationalId(String? value) {
    if (value == null || value.isEmpty) {
      return getTranslation('auth.national.id.required');
    }

    final nationalIdRegex = RegExp(r'^[0-9]{14}$');

    if (!nationalIdRegex.hasMatch(value)) {
      return getTranslation('auth.national.id.invalid');
    }

    return null;
  }

  // Birth date validation (YYYY-MM-DD format)
  static String? validateBirthDate(String? value) {
    if (value == null || value.isEmpty) {
      return getTranslation('auth.birth.date.required');
    }

    final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');

    if (!dateRegex.hasMatch(value)) {
      return getTranslation('auth.birth.date.invalid_format');
    }

    try {
      final date = DateTime.parse(value);
      final now = DateTime.now();
      final age = now.year - date.year;

      if (age < 18) {
        return getTranslation('auth.birth.date.minimum_age');
      }

      return null;
    } catch (e) {
      return getTranslation('auth.birth.date.invalid');
    }
  }

  // Gender validation
  static String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return getTranslation('auth.gender.required');
    }

    if (value != 'male' && value != 'female') {
      return getTranslation('auth.gender.invalid');
    }

    return null;
  }

  // Country code validation
  static String? validateCountryCode(String? value) {
    if (value == null || value.isEmpty) {
      return getTranslation('auth.country.code.required');
    }

    final countryCodeRegex = RegExp(r'^[A-Z]{2}$');

    if (!countryCodeRegex.hasMatch(value)) {
      return getTranslation('auth.country.code.invalid');
    }

    return null;
  }
}
