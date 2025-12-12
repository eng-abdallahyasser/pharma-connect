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

class SigninRequest {
  final String grantType;
  final String mobile;
  final String otp;
  final String clientId;
  final String deviceToken;
  final DeviceInfo deviceInfo;
  final String clientSecret;

  SigninRequest({
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

  factory SigninRequest.fromJson(Map<String, dynamic> json) {
    return SigninRequest(
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
