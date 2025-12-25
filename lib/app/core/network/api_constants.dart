class ApiConstants {
  static const String baseUrl = 'https://e-pharmacy-production.up.railway.app';

  // Auth Endpoints
  static const String login = '/api/auth/token';
  static const String signup = '/api/auth/signup';
  static const String sendOtp = '/api/auth/otp';
  static const String changeProfilePhoto = '/api/profile/photo';
  static const String getBranches = '/api/branches';
  static const String getNearbyBranches = '/api/branches/nearby';
  static const String getBranchDetails = '/api/branches/';
  static const String getProviders = '/api/providers';
  static const String getNearbyDoctors = '/api/doctors/nearby';

  // Headers
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Timeout durations
  static const int receiveTimeout = 15000;
  static const int connectTimeout = 15000;
}
