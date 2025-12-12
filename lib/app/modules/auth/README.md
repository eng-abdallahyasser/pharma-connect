# Auth Module Documentation

## Overview
The Auth module provides complete authentication functionality including login, registration, and password validation. It's fully integrated with the app's localization system (English & Arabic).

## Module Structure

```
lib/app/modules/auth/
├── bindings/
│   └── auth_binding.dart          # Dependency injection setup
├── controllers/
│   └── auth_controller.dart       # Authentication state management
├── models/
│   └── user_model.dart            # User data model
├── services/
│   └── auth_service.dart          # Authentication service logic
├── utils/
│   └── validators.dart            # Form validation utilities
├── views/
│   ├── login_view.dart            # Login screen UI
│   └── register_view.dart         # Registration screen UI
└── widgets/
    ├── custom_text_field.dart     # Reusable text input field
    ├── primary_button.dart        # Reusable primary button
    ├── auth_divider.dart          # Divider widget for auth screens
    └── social_login_button.dart   # Social login button
```

## Components

### Models

#### `UserModel`
Represents a user in the system with the following properties:
- `id`: Unique user identifier
- `email`: User email address
- `firstName`: User's first name
- `lastName`: User's last name
- `phoneNumber`: User's phone number
- `profileImage`: Optional profile image URL
- `createdAt`: Account creation timestamp
- `isEmailVerified`: Email verification status

**Methods:**
- `fullName`: Getter returning formatted full name
- `fromJson()`: Factory method for JSON deserialization
- `toJson()`: Serializes user to JSON

### Services

#### `AuthService`
Manages authentication logic and user session state. Extends `GetxService` for lifecycle management.

**Observable Properties:**
- `_currentUser`: Currently logged-in user
- `_isAuthenticated`: Authentication status
- `_isLoading`: Loading indicator for async operations

**Key Methods:**
- `login(email, password)`: Authenticate user with credentials
- `register(email, password, firstName, lastName, phoneNumber)`: Create new account
- `logout()`: Sign out current user
- `sendPasswordResetEmail(email)`: Initiate password reset
- `verifyEmail(email, code)`: Verify user email
- `updateProfile(...)`: Update user profile information

### Controllers

#### `AuthController`
State management controller extending `GetxController`. Manages form state and coordinates between UI and service layer.

**Observable States:**
- `isLoginPasswordVisible`: Login password visibility toggle
- `isRegisterPasswordVisible`: Registration password visibility toggle
- `isRegisterConfirmPasswordVisible`: Confirm password visibility toggle
- `isTermsAccepted`: Terms & conditions acceptance
- `isLoading`: Operation loading state
- `errorMessage`: Display error messages
- `successMessage`: Display success messages

**Form Controllers:**
- Login: `loginEmailController`, `loginPasswordController`
- Registration: `registerFirstNameController`, `registerLastNameController`, `registerEmailController`, `registerPhoneController`, `registerPasswordController`, `registerConfirmPasswordController`

**Key Methods:**
- `login()`: Validate and process login
- `register()`: Validate and process registration
- `toggleLoginPasswordVisibility()`: Show/hide password
- `toggleTermsAcceptance()`: Toggle terms checkbox
- `clearForm(type)`: Clear form fields and state
- Validator methods for each field

### Validators

#### `AuthValidators`
Static utility class for form validation with comprehensive checks:

**Validation Methods:**
- `validateEmail()`: Email format validation
- `validatePassword()`: Password strength requirements (8+ chars, uppercase, digit, special char)
- `validateConfirmPassword()`: Password match validation
- `validatePhoneNumber()`: Phone format validation
- `validateFirstName()`: Non-empty, min 2 characters
- `validateLastName()`: Non-empty, min 2 characters
- `validateTermsAccepted()`: Checkbox validation

### Views

#### `LoginView`
Complete login screen with:
- Email input field
- Password input with visibility toggle
- Forgot password link
- Social login options (Google, Facebook)
- Register link for new users
- Error message display
- Loading indicator

#### `RegisterView`
Complete registration screen with:
- First name input
- Last name input
- Email input
- Phone number input
- Password input with strength requirements display
- Confirm password input
- Terms & conditions checkbox
- Password requirements indicator
- Error message display
- Loading indicator

### Widgets

#### `CustomTextField`
Reusable text input field with:
- Label and hint text
- Optional prefix/suffix icons
- Form validation support
- Flexible keyboard types
- Password field support (obscureText)
- Customizable styling

#### `PrimaryButton`
Reusable primary action button with:
- Loading state with spinner
- Disabled state styling
- Customizable size and colors
- Rounded corners

#### `AuthDivider`
Visual divider for "OR" separation on auth screens

#### `SocialLoginButton`
Button for social media authentication (Google, Facebook, etc.)

## Translations

All UI text is fully translated to English and Arabic. Translation keys are namespaced under `auth.*`:

### Key Translation Categories:
- `auth.login.*`: Login screen strings
- `auth.register.*`: Registration screen strings
- `auth.email.*`: Email validation messages
- `auth.password.*`: Password validation messages
- `auth.*.name`: Input field labels
- `auth.*.hint`: Input field placeholders

**Example:**
```dart
// English (en_us.dart)
'auth.login.title': 'Welcome Back',
'auth.password.min_length': 'Password must be at least 8 characters',

// Arabic (ar_ar.dart)
'auth.login.title': 'أهلا بعودتك',
'auth.password.min_length': 'يجب أن تكون كلمة المرور 8 أحرف على الأقل',
```

## Routes

Auth routes are registered in `AppPages` and accessible via `AppRoutes`:

- `/login`: Login screen
- `/register`: Registration screen
- `/forgot-password`: Password reset screen (future)

## Usage Example

### Setup in main.dart
```dart
// The auth module is automatically initialized through AuthBinding
// Initial route can be set to /login for unauthenticated users
initialRoute: AppRoutes.login,
```

### Access Auth Controller
```dart
final authController = Get.find<AuthController>();
authController.login();
```

### Access Auth Service
```dart
final authService = Get.find<AuthService>();
final user = authService.currentUser;
final isAuthenticated = authService.isAuthenticated;
```

## Password Requirements

Password must contain:
1. Minimum 8 characters
2. At least one uppercase letter (A-Z)
3. At least one digit (0-9)
4. At least one special character (!@#$%^&*)

Visual requirement checker is shown during registration.

## State Management Pattern

The module uses GetX (Get package) for state management:

1. **Service Layer** (`AuthService`): Handles authentication logic and API calls
2. **Controller Layer** (`AuthController`): Manages UI state and form validation
3. **View Layer** (`LoginView`, `RegisterView`): Displays UI and responds to user input
4. **Binding** (`AuthBinding`): Injects dependencies

## Error Handling

Errors are displayed in user-friendly UI containers with translated messages:
- Network errors
- Validation errors
- Authentication failures
- Server errors

## Security Considerations

Current implementation is mock-based. For production:
1. Replace `AuthService` methods with actual API calls
2. Implement secure token storage (e.g., flutter_secure_storage)
3. Add JWT token handling
4. Implement refresh token mechanism
5. Add biometric authentication
6. Use HTTPS for all API calls

## Future Enhancements

- [ ] Password reset flow
- [ ] Email verification screen
- [ ] Social authentication integration
- [ ] Biometric login
- [ ] Session management
- [ ] Token refresh mechanism
- [ ] Two-factor authentication
- [ ] Account recovery options

## Testing

To test the auth module:

1. **Login:**
   - Any email format: `test@example.com`
   - Valid password (8+ chars, uppercase, digit, special): `Password1!`

2. **Registration:**
   - First & Last Name: Any name (min 2 chars)
   - Email: Valid email format
   - Phone: Valid phone format
   - Password: Meeting all requirements
   - Terms: Must accept

3. **Validation:**
   - Try submitting with empty fields
   - Try weak passwords
   - Try invalid email format
   - Try mismatched passwords
