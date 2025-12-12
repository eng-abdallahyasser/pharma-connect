class SignupResponse {
  final String id;
  final String email;
  final String mobile;
  final String firstName;
  final String middleName;
  final String lastName;
  final String? token;
  final String? refreshToken;

  SignupResponse({
    required this.id,
    required this.email,
    required this.mobile,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    this.token,
    this.refreshToken,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      id: json['id'] as String? ?? '',
      email: json['email'] as String,
      mobile: json['mobile'] as String,
      firstName: json['firstName'] as String,
      middleName: json['middleName'] as String,
      lastName: json['lastName'] as String,
      token: json['token'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'mobile': mobile,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'token': token,
      'refreshToken': refreshToken,
    };
  }
}
