import 'login_response.dart';

class SignupResponse {
  final String? accessToken;
  final String? refreshToken;
  final DateTime? expireAt;
  final User user;

  SignupResponse({
    this.accessToken,
    this.refreshToken,
    this.expireAt,
    required this.user,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
      expireAt: json['expireAt'] != null
          ? DateTime.parse(json['expireAt'] as String)
          : null,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (accessToken != null) 'access_token': accessToken,
      if (refreshToken != null) 'refresh_token': refreshToken,
      'expireAt': expireAt,
      'user': user.toJson(),
    };
  }
}
