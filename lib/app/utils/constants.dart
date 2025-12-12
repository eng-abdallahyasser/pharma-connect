// App Constants
class AppConstants {
  static const String appName = 'Pharma Connect';
  static const String appVersion = '1.0.0';

  // API Endpoints (update with your backend URLs)
  static const String baseUrl = 'https://api.example.com';

  // Timeouts
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
}

// String Constants
class StringConstants {
  // Error Messages
  static const String errorGeneral = 'Something went wrong';
  static const String errorNetwork = 'Network error';
  static const String errorTimeout = 'Request timeout';

  // Success Messages
  static const String successSaved = 'Saved successfully';
  static const String successDeleted = 'Deleted successfully';
}

// Asset Paths
class AssetPath {
  static const String imagesPath = 'assets/images';
  static const String iconsPath = 'assets/icons';
  static const String animationsPath = 'assets/animations';

  // Images
  // static const String logoImage = '$imagesPath/logo.png';

  // Icons
  // static const String homeIcon = '$_iconsPath/home.svg';

  // Animations
  // static const String loadingAnimation = '$_animationsPath/loading.json';
}
