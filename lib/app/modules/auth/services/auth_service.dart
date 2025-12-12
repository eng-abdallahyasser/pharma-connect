import 'package:get/get.dart';
import '../models/user_model.dart';

class AuthService extends GetxService {
  // Observable for current user
  final _currentUser = Rx<UserModel?>(null);
  final _isAuthenticated = false.obs;
  final _isLoading = false.obs;

  UserModel? get currentUser => _currentUser.value;
  bool get isAuthenticated => _isAuthenticated.value;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    // Initialize auth state (check if user is logged in)
    _checkAuthStatus();
  }

  // Check if user is already authenticated
  Future<void> _checkAuthStatus() async {
    _isLoading.value = true;
    try {
      // Simulate checking stored user session
      // In real app, you would check shared preferences or secure storage
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      print('Error checking auth status: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  // Login with email and password
  Future<bool> login(String email, String password) async {
    _isLoading.value = true;
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Mock user creation - in real app, this comes from API
      final user = UserModel(
        id: '${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        firstName: email.split('@')[0],
        lastName: 'User',
        phoneNumber: '+1234567890',
        createdAt: DateTime.now(),
        isEmailVerified: true,
      );

      _currentUser.value = user;
      _isAuthenticated.value = true;

      // Store user session (in real app)
      // await _storeUserSession(user);

      return true;
    } catch (e) {
      print('Login error: $e');
      return false;
    } finally {
      _isLoading.value = false;
    }
  }

  // Register new user
  Future<bool> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    _isLoading.value = true;
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      final user = UserModel(
        id: '${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        createdAt: DateTime.now(),
        isEmailVerified: false,
      );

      _currentUser.value = user;
      _isAuthenticated.value = true;

      // Store user session (in real app)
      // await _storeUserSession(user);

      return true;
    } catch (e) {
      print('Registration error: $e');
      return false;
    } finally {
      _isLoading.value = false;
    }
  }

  // Logout user
  Future<void> logout() async {
    _isLoading.value = true;
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

      _currentUser.value = null;
      _isAuthenticated.value = false;

      // Clear stored session (in real app)
      // await _clearUserSession();
    } catch (e) {
      print('Logout error: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  // Send password reset email
  Future<bool> sendPasswordResetEmail(String email) async {
    _isLoading.value = true;
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      return true;
    } catch (e) {
      print('Password reset error: $e');
      return false;
    } finally {
      _isLoading.value = false;
    }
  }

  // Verify email
  Future<bool> verifyEmail(String email, String code) async {
    _isLoading.value = true;
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      if (_currentUser.value != null) {
        _currentUser.value = UserModel(
          id: _currentUser.value!.id,
          email: _currentUser.value!.email,
          firstName: _currentUser.value!.firstName,
          lastName: _currentUser.value!.lastName,
          phoneNumber: _currentUser.value!.phoneNumber,
          profileImage: _currentUser.value!.profileImage,
          createdAt: _currentUser.value!.createdAt,
          isEmailVerified: true,
        );
      }
      return true;
    } catch (e) {
      print('Email verification error: $e');
      return false;
    } finally {
      _isLoading.value = false;
    }
  }

  // Update user profile
  Future<bool> updateProfile({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? profileImage,
  }) async {
    _isLoading.value = true;
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      if (_currentUser.value != null) {
        _currentUser.value = UserModel(
          id: _currentUser.value!.id,
          email: _currentUser.value!.email,
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          profileImage: profileImage ?? _currentUser.value!.profileImage,
          createdAt: _currentUser.value!.createdAt,
          isEmailVerified: _currentUser.value!.isEmailVerified,
        );
      }
      return true;
    } catch (e) {
      print('Profile update error: $e');
      return false;
    } finally {
      _isLoading.value = false;
    }
  }
}
