class AuthValidators {
  // Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'email.required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'email.invalid';
    }

    return null;
  }

  // Password validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'password.required';
    }

    if (value.length < 8) {
      return 'password.min_length';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'password.uppercase';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'password.digit';
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'password.special_char';
    }

    return null;
  }

  // Confirm password validation
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'password.required';
    }

    if (value != password) {
      return 'password.mismatch';
    }

    return null;
  }

  // Phone number validation
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'phone.required';
    }

    final phoneRegex = RegExp(
      r'^[+]?[(]?[0-9]{3}[)]?[-\s.]?[0-9]{3}[-\s.]?[0-9]{4,6}$',
    );

    if (!phoneRegex.hasMatch(value)) {
      return 'phone.invalid';
    }

    return null;
  }

  // First name validation
  static String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'first_name.required';
    }

    if (value.length < 2) {
      return 'first_name.min_length';
    }

    return null;
  }

  // Middle name validation
  static String? validateMiddleName(String? value) {
    if (value == null || value.isEmpty) {
      return 'middle_name.required';
    }

    if (value.length < 2) {
      return 'middle_name.min_length';
    }

    return null;
  }

  // Last name validation
  static String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'last_name.required';
    }

    if (value.length < 2) {
      return 'last_name.min_length';
    }

    return null;
  }

  // Terms acceptance validation
  static String? validateTermsAccepted(bool? value) {
    if (value != true) {
      return 'terms.required';
    }

    return null;
  }

  // National ID validation (14 digits)
  static String? validateNationalId(String? value) {
    if (value == null || value.isEmpty) {
      return 'national_id.required';
    }

    final nationalIdRegex = RegExp(r'^[0-9]{14}$');

    if (!nationalIdRegex.hasMatch(value)) {
      return 'national_id.invalid';
    }

    return null;
  }

  // Birth date validation (YYYY-MM-DD format)
  static String? validateBirthDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'birth_date.required';
    }

    final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');

    if (!dateRegex.hasMatch(value)) {
      return 'birth_date.invalid_format';
    }

    try {
      final date = DateTime.parse(value);
      final now = DateTime.now();
      final age = now.year - date.year;

      if (age < 18) {
        return 'birth_date.minimum_age';
      }

      return null;
    } catch (e) {
      return 'birth_date.invalid';
    }
  }

  // Gender validation
  static String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'gender.required';
    }

    if (value != 'male' && value != 'female') {
      return 'gender.invalid';
    }

    return null;
  }

  // Country code validation
  static String? validateCountryCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'country_code.required';
    }

    final countryCodeRegex = RegExp(r'^[A-Z]{2}$');

    if (!countryCodeRegex.hasMatch(value)) {
      return 'country_code.invalid';
    }

    return null;
  }
}
