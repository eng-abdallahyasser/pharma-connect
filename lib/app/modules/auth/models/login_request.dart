class DeviceInfo {
  final String brand;
  final String deviceType;
  final String osVersion;

  DeviceInfo({
    required this.brand,
    required this.deviceType,
    required this.osVersion,
  });

  Map<String, dynamic> toJson() {
    return {'brand': brand, 'deviceType': deviceType, 'osVersion': osVersion};
  }

  factory DeviceInfo.fromJson(Map<String, dynamic> json) {
    return DeviceInfo(
      brand: json['brand'] as String,
      deviceType: json['deviceType'] as String,
      osVersion: json['osVersion'] as String,
    );
  }
}

class LoginRequest {
  final String grantType;
  final String? email;
  final String? password;
  final String? mobile;
  final String? otp;
  final String clientId;
  final String deviceToken;
  final DeviceInfo deviceInfo;
  final String clientSecret;

  LoginRequest({
    required this.grantType,
    this.email,
    this.password,
    this.mobile,
    this.otp,
    required this.clientId,
    required this.deviceToken,
    required this.deviceInfo,
    required this.clientSecret,
  });

  Map<String, dynamic> toJson() {
    return {
      'grant_type': grantType,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (mobile != null) 'mobile': mobile,
      if (otp != null) 'otp': otp,
      'client_id': clientId,
      'device_token': deviceToken,
      'device_info': deviceInfo.toJson(),
      'client_secret': clientSecret,
    };
  }

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      grantType: json['grant_type'] as String,
      email: json['email'] as String?,
      password: json['password'] as String?,
      mobile: json['mobile'] as String?,
      otp: json['otp'] as String?,
      clientId: json['client_id'] as String,
      deviceToken: json['device_token'] as String,
      deviceInfo: DeviceInfo.fromJson(
        json['device_info'] as Map<String, dynamic>,
      ),
      clientSecret: json['client_secret'] as String,
    );
  }
}

// OTP Login Request for signin
class OtpLoginRequest {
  final String grantType;
  final String mobile;
  final String otp;
  final String clientId;
  final String deviceToken;
  final DeviceInfo deviceInfo;
  final String clientSecret;

  OtpLoginRequest({
    required this.grantType,
    required this.mobile,
    required this.otp,
    required this.clientId,
    required this.deviceToken,
    required this.deviceInfo,
    required this.clientSecret,
  });

  Map<String, dynamic> toJson() {
    return {
      'grant_type': grantType,
      'mobile': mobile,
      'otp': otp,
      'client_id': clientId,
      'device_token': deviceToken,
      'device_info': deviceInfo.toJson(),
      'client_secret': clientSecret,
    };
  }

  factory OtpLoginRequest.fromJson(Map<String, dynamic> json) {
    return OtpLoginRequest(
      grantType: json['grant_type'] as String,
      mobile: json['mobile'] as String,
      otp: json['otp'] as String,
      clientId: json['client_id'] as String,
      deviceToken: json['device_token'] as String,
      deviceInfo: DeviceInfo.fromJson(
        json['device_info'] as Map<String, dynamic>,
      ),
      clientSecret: json['client_secret'] as String,
    );
  }
}
