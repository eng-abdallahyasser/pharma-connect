class SignupRequest {
  final String mobile;
  final String firstName;
  final String middleName;
  final String lastName;
  final String password;
  final String nationalId;
  final String email;
  final String gender;
  final String birthDate;
  final String countryCode;

  SignupRequest({
    required this.mobile,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.password,
    required this.nationalId,
    required this.email,
    required this.gender,
    required this.birthDate,
    required this.countryCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'mobile': mobile,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'password': password,
      'nationalId': nationalId,
      'email': email,
      'gender': gender,
      'birthDate': birthDate,
      'countryCode': countryCode,
    };
  }

  factory SignupRequest.fromJson(Map<String, dynamic> json) {
    return SignupRequest(
      mobile: json['mobile'] as String,
      firstName: json['firstName'] as String,
      middleName: json['middleName'] as String,
      lastName: json['lastName'] as String,
      password: json['password'] as String,
      nationalId: json['nationalId'] as String,
      email: json['email'] as String,
      gender: json['gender'] as String,
      birthDate: json['birthDate'] as String,
      countryCode: json['countryCode'] as String,
    );
  }
}
