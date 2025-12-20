import 'login_response.dart';

class SignupResponse {
  final String? accessToken;
  final String? refreshToken;
  final DateTime? expireAt;
  final User? user;
  final int? statusCode;
  final String? errorCode;
  final String? path;
  final String? message;
  final List<ValidationError>? errors;
  final String? requestId;
  final String? timestamp;

  SignupResponse({
    this.accessToken,
    this.refreshToken,
    this.expireAt,
    this.user,
    this.statusCode,
    this.errorCode,
    this.path,
    this.message,
    this.errors,
    this.requestId,
    this.timestamp,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
      expireAt: json['expireAt'] != null
          ? DateTime.parse(json['expireAt'] as String)
          : null,
      user: json['user'] != null
          ? User.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      statusCode: json['statusCode'] as int?,
      errorCode: json['errorCode'] as String?,
      path: json['path'] as String?,
      message: json['message'] as String?,
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => ValidationError.fromJson(e as Map<String, dynamic>))
          .toList(),
      requestId: json['requestId'] as String?,
      timestamp: json['timestamp'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (accessToken != null) 'access_token': accessToken,
      if (refreshToken != null) 'refresh_token': refreshToken,
      if (expireAt != null) 'expireAt': expireAt,
      if (user != null) 'user': user?.toJson(),
      if (statusCode != null) 'statusCode': statusCode,
      if (errorCode != null) 'errorCode': errorCode,
      if (path != null) 'path': path,
      if (message != null) 'message': message,
      if (errors != null) 'errors': errors?.map((e) => e.toJson()).toList(),
      if (requestId != null) 'requestId': requestId,
      if (timestamp != null) 'timestamp': timestamp,
    };
  }
}

class ValidationError {
  final String? property;
  final String? value;
  final Map<String, dynamic>? constraints;
  final String? message;
  final String? code;

  ValidationError({
    this.property,
    this.value,
    this.constraints,
    this.message,
    this.code,
  });

  factory ValidationError.fromJson(Map<String, dynamic> json) {
    return ValidationError(
      property: json['property'] as String?,
      value: json['value'] as String?,
      constraints: json['constraints'] as Map<String, dynamic>?,
      message: json['message'] as String?,
      code: json['code'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (property != null) 'property': property,
      if (value != null) 'value': value,
      if (constraints != null) 'constraints': constraints,
      if (message != null) 'message': message,
      if (code != null) 'code': code,
    };
  }
}
