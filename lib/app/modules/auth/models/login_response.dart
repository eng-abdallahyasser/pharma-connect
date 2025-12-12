class LoginResponse {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? mobile;
  final String? token;
  final String? refreshToken;

  LoginResponse({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.mobile,
    this.token,
    this.refreshToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      id: json['id'] as String? ?? '',
      email: json['email'] as String,
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      mobile: json['mobile'] as String?,
      token: json['token'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'token': token,
      'refreshToken': refreshToken,
    };
  }
}
