import 'dart:developer';

import 'package:get/get.dart';
import 'package:pharma_connect/app/core/services/storage_service.dart';
import 'package:pharma_connect/app/modules/auth/models/signup_response.dart';
import '../models/user_model.dart';
import '../models/signup_request.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import 'auth_repository.dart';

class AuthService extends GetxService {
  // Observable for current user
  final _currentUser = Rx<UserModel?>(null);
  final _isAuthenticated = false.obs;
  final _isLoading = false.obs;
  late AuthRepository _authRepository;

  UserModel? get currentUser => _currentUser.value;
  bool get isAuthenticated => _isAuthenticated.value;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    _authRepository = AuthRepository();
    // Initialize auth state (check if user is logged in)
    _checkAuthStatus();
  }

  // Check if user is already authenticated by retrieving stored token
  Future<void> _checkAuthStatus() async {
    _isLoading.value = true;
    try {
      final storageService = Get.find<StorageService>();
      final token = storageService.getToken();
      final user = storageService.getUser();

      if (token != null && user != null) {
        // User has a stored token and user data, restore the session
        _currentUser.value = user;
        _isAuthenticated.value = true;
        log('User session restored from storage');
      } else {
        // No stored session found
        _isAuthenticated.value = false;
        log('No stored user session found');
      }
    } catch (e) {
      log('Error checking auth status: $e');
      _isAuthenticated.value = false;
    } finally {
      _isLoading.value = false;
    }
  }

  // Login with email and password
  Future<LoginResponse> login(String email, String password) async {
    _isLoading.value = true;
    try {
      final loginRequest = LoginRequest(
        grantType: 'password',
        email: email,
        password: password,
        otp: '999999',
        clientId: 'mobile_app',
        deviceToken: 'ExponentPushToken[8qSTYvDW3NpPuqqCCqAHTS]',
        deviceInfo: DeviceInfo(
          brand: 'google',
          deviceType: 'mobile',
          osVersion: '4.0.3',
        ),
        clientSecret: 'secret',
      );
      log('Login Request: ${loginRequest.toJson()}');
      final response = await _authRepository.login(loginRequest);

      // Check if user exists in response
      if (response.user != null) {
        // Create user model from response
        final user = UserModel(
          id: response.user!.id,
          email: response.user!.email,
          firstName: response.user!.firstName,
          lastName: response.user!.lastName,
          phoneNumber: response.user!.mobile ?? '',
          createdAt: response.user!.metadata?.createdAt ?? DateTime.now(),
          isEmailVerified: response.user!.emailVerified,
        );

        // Store token and user data if provided
        if (response.accessToken != null) {
          final storageService = Get.find<StorageService>();
          await storageService.saveToken(response.accessToken!);
          await storageService.saveUser(user);
        }

        _currentUser.value = user;
        _isAuthenticated.value = true;
      }

      return response;
    } catch (e) {
      log('Login Error Auth Service: $e');
      return LoginResponse(user: null, message: e.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  // Login with OTP (Signin)
  Future<bool> loginWithOtp(OtpLoginRequest otpLoginRequest) async {
    _isLoading.value = true;
    try {
      final response = await _authRepository.loginWithOtp(otpLoginRequest);

      if (response.user != null) {
        // Create user model from response
        final user = UserModel(
          id: response.user!.id,
          email: response.user!.email,
          firstName: response.user!.firstName,
          lastName: response.user!.lastName,
          phoneNumber: response.user!.mobile ?? otpLoginRequest.mobile,
          createdAt: response.user!.metadata?.createdAt ?? DateTime.now(),
          isEmailVerified: response.user!.emailVerified,
        );

        // Store token and user data if provided
        if (response.accessToken != null) {
          final storageService = Get.find<StorageService>();
          await storageService.saveToken(response.accessToken!);
          await storageService.saveUser(user);
        }

        _currentUser.value = user;
        _isAuthenticated.value = true;

        return true;
      }
      return false;
    } catch (e) {
      log('Login with OTP error: $e');
      return false;
    } finally {
      _isLoading.value = false;
    }
  }

  // Register new user with signup request
  Future<bool> signup(SignupRequest signupRequest) async {
    _isLoading.value = true;
    try {
      final response = await _authRepository.signup(signupRequest);
      log('Signup Response: ${response.toJson()}');

      if (response.user == null) {
        log(
          'Signup failed: ${response.message ?? response.errorCode ?? "Unknown error"}',
        );
        return false;
      }

      // Create user model from response
      final user = UserModel(
        id: response.user!.id,
        email: response.user!.email,
        firstName: response.user!.firstName,
        lastName: response.user!.lastName,
        phoneNumber: response.user!.mobile ?? '',
        createdAt: response.user!.metadata?.createdAt ?? DateTime.now(),
        isEmailVerified: response.user!.emailVerified,
      );

      // Store token and user data if provided
      if (response.accessToken != null) {
        final storageService = Get.find<StorageService>();
        await storageService.saveToken(response.accessToken!);
        await storageService.saveUser(user);
      }

      _currentUser.value = user;
      _isAuthenticated.value = true;

      return true;
    } catch (e) {
      log('Signup error: $e');
      return false;
    } finally {
      _isLoading.value = false;
    }
  }

  // Register new user
  Future<SignupResponse?> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? middleName,
    String? gender,
    String? birthDate,
    String? countryCode,
    String? nationalId,
  }) async {
    _isLoading.value = true;
    try {
      // Simulate API call

      if (phoneNumber.startsWith('0')) {
        phoneNumber = phoneNumber.substring(1);
      } else if (phoneNumber.startsWith('+20')) {
        phoneNumber = phoneNumber.substring(3);
      }
      final body = {
        "mobile": phoneNumber,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "password": password,
        "nationalId": nationalId,
        "email": email,
        "gender": gender ?? "male",
        "birthDate": birthDate ?? "1999-02-14",
        "countryCode": "eg",
      };

      final response = await _authRepository.signup(
        SignupRequest.fromJson(body),
      );

      if (response.user == null) {
        return response;
      }

      final user = UserModel(
        id: response.user!.id,
        email: email,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        createdAt: DateTime.now(),
        isEmailVerified: false,
      );

      // Store token and user data if provided
      if (response.accessToken != null) {
        final storageService = Get.find<StorageService>();
        await storageService.saveToken(response.accessToken!);
        await storageService.saveUser(user);
      }

      _currentUser.value = user;
      _isAuthenticated.value = true;

      return response;
    } catch (e) {
      log('Registration error: $e');
    } finally {
      _isLoading.value = false;
    }
    return null;
  }

  // Logout user
  Future<void> logout() async {
    _isLoading.value = true;
    try {
      // Clear stored token and user data
      final storageService = Get.find<StorageService>();
      await storageService.removeToken();
      await storageService.removeUser();

      _currentUser.value = null;
      _isAuthenticated.value = false;

      log('User logged out and session cleared');
    } catch (e) {
      log('Logout error: $e');
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
      log('Password reset error: $e');
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
      log('Email verification error: $e');
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
      log('Profile update error: $e');
      return false;
    } finally {
      _isLoading.value = false;
    }
  }
}
