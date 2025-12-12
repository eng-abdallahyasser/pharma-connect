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
}
