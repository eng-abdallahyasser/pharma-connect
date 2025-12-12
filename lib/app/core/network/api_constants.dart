class ApiConstants {
  static const String baseUrl = 'https://e-pharmacy-production.up.railway.app';

  // Auth Endpoints
  static const String login = '/api/auth/token';
  static const String signup = '/api/auth/signup';
  static const String sendOtp = '/api/auth/otp';

  // Headers
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Timeout durations
  static const int receiveTimeout = 15000;
  static const int connectTimeout = 15000;
}
