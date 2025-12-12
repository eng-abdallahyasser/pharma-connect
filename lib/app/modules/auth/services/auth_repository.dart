import 'package:pharma_connect/app/core/network/api_client.dart';
import 'package:pharma_connect/app/core/network/api_constants.dart';
import '../models/signup_request.dart';
import '../models/signup_response.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

class AuthRepository {
  final ApiClient _apiClient = ApiClient();

  /// Signup user with the provided credentials
  Future<SignupResponse> signup(SignupRequest signupRequest) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.signup,
        signupRequest.toJson(),
      );

      return SignupResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  /// Login user with email and password
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.login,
        loginRequest.toJson(),
      );

      return LoginResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  /// Login/Signin user with OTP
  Future<LoginResponse> loginWithOtp(OtpLoginRequest otpLoginRequest) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.login,
        otpLoginRequest.toJson(),
      );

      return LoginResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  /// Send OTP to email or phone
  Future<Map<String, dynamic>> sendOtp(String identifier) async {
    try {
      final response = await _apiClient.post(ApiConstants.sendOtp, {
        'identifier': identifier,
      });

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
